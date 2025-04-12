import os
import glob
import numpy as np
import torch
import matplotlib.pyplot as plt
from sklearn.metrics import confusion_matrix, classification_report
import seaborn as sns
import argparse
from tqdm import tqdm

from train_standalone import RobotNavigationModel, RobotNavigationDataset

def load_model(model_path, device):
    """Load the trained model"""
    model = RobotNavigationModel(pretrained=False)
    
    # Load model weights
    checkpoint = torch.load(model_path, map_location=device)
    
    # Handle both direct state_dict and checkpoint dictionary formats
    if 'model_state_dict' in checkpoint:
        model.load_state_dict(checkpoint['model_state_dict'])
    else:
        model.load_state_dict(checkpoint)
    
    model.to(device)
    model.eval()
    return model

def evaluate_model(model, test_loader, device):
    """Evaluate model on test data"""
    cte_preds = []
    he_preds = []
    cte_targets = []
    he_targets = []
    
    # Create progress bar
    progress_bar = tqdm(test_loader, desc="Testing")
    
    with torch.no_grad():
        for images, cte_target, he_target in progress_bar:
            # Move to device
            images = images.to(device)
            
            # Forward pass
            cte_output, he_output = model(images)
            
            # Get predictions
            _, cte_pred = torch.max(cte_output, 1)
            _, he_pred = torch.max(he_output, 1)
            
            # Store results
            cte_preds.extend(cte_pred.cpu().numpy())
            he_preds.extend(he_pred.cpu().numpy())
            cte_targets.extend(cte_target.numpy())
            he_targets.extend(he_target.numpy())
    
    return np.array(cte_preds), np.array(he_preds), np.array(cte_targets), np.array(he_targets)

def create_confusion_matrices(cte_preds, he_preds, cte_targets, he_targets, output_dir):
    """Create and save confusion matrices"""
    # Define class names
    cte_class_names = ['Left', 'Middle', 'Right']
    he_class_names = ['Extreme Left', 'Left', 'Straight', 'Right', 'Extreme Right']
    
    # Create CTE confusion matrix
    plt.figure(figsize=(10, 8))
    cte_cm = confusion_matrix(cte_targets, cte_preds)
    sns.heatmap(cte_cm, annot=True, fmt='d', cmap='Blues', 
                xticklabels=cte_class_names, yticklabels=cte_class_names)
    plt.xlabel('Predicted')
    plt.ylabel('True')
    plt.title('Cross-Track Error (CTE) Confusion Matrix')
    plt.tight_layout()
    plt.savefig(os.path.join(output_dir, 'cte_confusion_matrix.png'))
    
    # Create HE confusion matrix
    plt.figure(figsize=(12, 10))
    he_cm = confusion_matrix(he_targets, he_preds)
    sns.heatmap(he_cm, annot=True, fmt='d', cmap='Blues',
                xticklabels=he_class_names, yticklabels=he_class_names)
    plt.xlabel('Predicted')
    plt.ylabel('True')
    plt.title('Heading Error (HE) Confusion Matrix')
    plt.tight_layout()
    plt.savefig(os.path.join(output_dir, 'he_confusion_matrix.png'))
    
    return cte_cm, he_cm

def visualize_sample_predictions(model, test_loader, device, output_dir, num_samples=5):
    """Visualize some sample predictions"""
    # Get a batch of samples
    images, cte_targets, he_targets = next(iter(test_loader))
    
    # Make predictions
    with torch.no_grad():
        images_device = images[:num_samples].to(device)
        cte_output, he_output = model(images_device)
        _, cte_preds = torch.max(cte_output, 1)
        _, he_preds = torch.max(he_output, 1)
    
    # Create mapping from numerical classes to labels
    cte_labels = ['Left', 'Middle', 'Right']
    he_labels = ['Extreme Left', 'Left', 'Straight', 'Right', 'Extreme Right']
    
    # Plot the samples
    fig, axes = plt.subplots(num_samples, 1, figsize=(12, 4*num_samples))
    
    for i in range(num_samples):
        # Convert image tensor to numpy for plotting
        img = images[i].permute(1, 2, 0).cpu().numpy()
        # Denormalize if needed
        img = np.clip(img, 0, 1)
        
        # Get predictions and targets
        cte_pred = cte_preds[i].item()
        he_pred = he_preds[i].item()
        cte_target = cte_targets[i].item()
        he_target = he_targets[i].item()
        
        # Plot image and predictions
        axes[i].imshow(img)
        axes[i].set_title(f"CTE: {cte_labels[cte_target]} (Pred: {cte_labels[cte_pred]}), " + 
                         f"HE: {he_labels[he_target]} (Pred: {he_labels[he_pred]})")
        axes[i].axis('off')
    
    plt.tight_layout()
    plt.savefig(os.path.join(output_dir, 'sample_predictions.png'))

def main():
    parser = argparse.ArgumentParser(description='Test robot navigation model')
    parser.add_argument('--model_path', type=str, required=True, help='Path to saved model')
    parser.add_argument('--data_dir', type=str, required=True, help='Directory containing test data')
    parser.add_argument('--output_dir', type=str, default='./results', help='Directory to save results')
    parser.add_argument('--batch_size', type=int, default=32, help='Batch size')
    parser.add_argument('--num_samples', type=int, default=20, help='Number of samples to use (set to 0 for all)')
    parser.add_argument('--max_files', type=int, default=None, help='Maximum number of files to use for testing')
    parser.add_argument('--use_cpu', action='store_true', help='Force CPU usage')
    args = parser.parse_args()
    
    # Set device
    device = torch.device('cpu') if args.use_cpu else torch.device('cuda' if torch.cuda.is_available() else 'cpu')
    print(f"Using device: {device}")
    
    # Create output directory if it doesn't exist
    os.makedirs(args.output_dir, exist_ok=True)
    
    # Load the model
    print(f"Loading model from {args.model_path}")
    model = load_model(args.model_path, device)
    
    # Create test dataset
    print(f"Loading test data from {args.data_dir}")
    test_dataset = RobotNavigationDataset(
        args.data_dir, 
        transform=None,  # Use default transformation
        max_files=args.max_files,
        sample_limit=args.num_samples if args.num_samples > 0 else None
    )
    
    # Create test dataloader
    test_loader = torch.utils.data.DataLoader(
        test_dataset,
        batch_size=args.batch_size,
        shuffle=False,
        num_workers=1
    )
    
    print(f"Testing model on {len(test_dataset)} samples")
    
    # Evaluate model
    cte_preds, he_preds, cte_targets, he_targets = evaluate_model(model, test_loader, device)
    
    # Create confusion matrices
    print("Creating confusion matrices...")
    create_confusion_matrices(cte_preds, he_preds, cte_targets, he_targets, args.output_dir)
    
    # Generate classification reports
    print("\nCTE Classification Report:")
    cte_report = classification_report(
        cte_targets, cte_preds,
        target_names=['Left', 'Middle', 'Right']
    )
    print(cte_report)
    
    print("\nHE Classification Report:")
    he_report = classification_report(
        he_targets, he_preds,
        target_names=['Extreme Left', 'Left', 'Straight', 'Right', 'Extreme Right']
    )
    print(he_report)
    
    # Save reports to file
    with open(os.path.join(args.output_dir, 'classification_reports.txt'), 'w') as f:
        f.write("Cross-Track Error (CTE) Classification Report:\n")
        f.write(cte_report)
        f.write("\n\nHeading Error (HE) Classification Report:\n")
        f.write(he_report)
    
    # Calculate overall accuracy
    cte_accuracy = (cte_preds == cte_targets).mean() * 100
    he_accuracy = (he_preds == he_targets).mean() * 100
    
    print(f"\nOverall Test Accuracy:")
    print(f"CTE Accuracy: {cte_accuracy:.2f}%")
    print(f"HE Accuracy: {he_accuracy:.2f}%")
    
    # Save overall accuracy to file
    with open(os.path.join(args.output_dir, 'overall_accuracy.txt'), 'w') as f:
        f.write(f"Test Set Size: {len(test_dataset)} samples\n")
        f.write(f"CTE Accuracy: {cte_accuracy:.2f}%\n")
        f.write(f"HE Accuracy: {he_accuracy:.2f}%\n")
    
    # Visualize sample predictions
    print("Visualizing sample predictions...")
    visualize_sample_predictions(model, test_loader, device, args.output_dir, num_samples=5)
    
    print(f"Testing complete! Results saved to {args.output_dir}")

if __name__ == "__main__":
    main()