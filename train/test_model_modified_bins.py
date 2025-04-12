import os
import glob
import numpy as np
import torch
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.metrics import confusion_matrix, classification_report
import seaborn as sns
import argparse
from tqdm import tqdm
from torch.utils.data import Subset
import torch.nn.functional as F

from train_modified_bins import RobotNavigationModel, RobotNavigationDataset

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

def conformalize_model(model, test_loader, cal_loader, alpha, device):
    """Calibrate model on calibration data and then evaluate on test data"""
    print("Conformalizing with alpha=", alpha)
    cte_nonconf_scores = []
    he_nonconf_scores = []
    
    # Create progress bar
    progress_bar = tqdm(cal_loader, desc="Conformalizing")
    
    with torch.no_grad():
        for images, cte_target, he_target in progress_bar:
            # Move to device
            images = images.to(device)
            
            # Forward pass
            cte_output, he_output = model(images)
            
            # Get predictions
            _, cte_pred = torch.max(cte_output, 1)
            _, he_pred = torch.max(he_output, 1)

            # -------------------------------------------------------------------
            # Compute nonconformity scores
            # -------------------------------------------------------------------
            # 1) Convert model logits to probabilities
            cte_probs = F.softmax(cte_output, dim=1)   # shape: (batch_size, #cte_classes)
            he_probs  = F.softmax(he_output, dim=1)    # shape: (batch_size, #he_classes)

            # 2) Gather probability of the TRUE class for each sample
            batch_size = images.size(0)
            cte_correct_probs = cte_probs[torch.arange(batch_size, device=device), cte_target]
            he_correct_probs  = he_probs[torch.arange(batch_size, device=device), he_target]

            # 3) Compute nonconformity = 1 - p(true class)
            cte_nonconf = 1 - cte_correct_probs
            he_nonconf  = 1 - he_correct_probs

            # 4) Store them
            cte_nonconf_scores.extend(cte_nonconf.cpu().tolist())
            he_nonconf_scores.extend(he_nonconf.cpu().tolist())

    # ----------------------------------------------------------------------
    # After the loop, we have all nonconformity scores in cte_nonconf_scores, 
    # he_nonconf_scores. Now compute the "adjusted" quantile.
    # ----------------------------------------------------------------------
    # Convert to NumPy arrays (if desired)
    cte_nonconf_scores = np.array(cte_nonconf_scores)
    he_nonconf_scores  = np.array(he_nonconf_scores)

    # Number of calibration samples for each task
    n_cte = len(cte_nonconf_scores)
    n_he  = len(he_nonconf_scores)

    # 1) Adjusted quantile level
    cte_q_level = np.ceil((n_cte + 1) * (1 - alpha)) / n_cte
    he_q_level  = np.ceil((n_he  + 1) * (1 - alpha)) / n_he

    # 2) Get the quantiles
    cte_qhat = np.quantile(cte_nonconf_scores, cte_q_level, interpolation='higher')
    he_qhat  = np.quantile(he_nonconf_scores,  he_q_level,  interpolation='higher')

    print("CTE adjusted quantile:", cte_qhat)
    print("HE  adjusted quantile:", he_qhat)

    
    cte_targets = []
    he_targets = []
    cte_predset = []
    he_predset = []

     # Create progress bar
    progress_bar = tqdm(test_loader, desc="Testing")

    with torch.no_grad():
        for images, cte_target, he_target in progress_bar:
            # Move to device
            images = images.to(device)

            # Forward pass => (batch_size, num_cte_classes), (batch_size, num_he_classes)
            cte_output, he_output = model(images)

            # Record true labels:
            cte_targets.extend(cte_target.numpy())
            he_targets.extend(he_target.numpy())

            # Convert logits to probabilities
            cte_probs = F.softmax(cte_output, dim=1)  # shape: (B, num_cte_classes)
            he_probs  = F.softmax(he_output, dim=1)   # shape: (B, num_he_classes)
            

            # Form prediction sets:
            #     Nonconformity (1 - prob_of_class) <= qhat
            #     => prob_of_class >= 1 - qhat
            cte_predset_bool = cte_probs >= (1 - cte_qhat)  # shape: (B, num_cte_classes), bool
            he_predset_bool  = he_probs  >= (1 - he_qhat)

            # Convert boolean masks to integer form (0 or 1)
            cte_predset_int = cte_predset_bool.to(torch.int)
            he_predset_int  = he_predset_bool.to(torch.int)

            # Store these masks (on CPU) in a list
            cte_predset.append(cte_predset_int.cpu())
            he_predset.append(he_predset_int.cpu())
    
    # Concatenate all batches along the 0th dimension
    all_cte_predset = np.array(torch.cat(cte_predset, dim=0))  # shape: (total_samples, num_cte_classes)
    all_he_predset  = np.array(torch.cat(he_predset, dim=0))   # shape: (total_samples, num_he_classes)
    cte_targets = np.array(cte_targets) 
    he_targets = np.array(he_targets)


    empirical_coverage_cte = all_cte_predset[np.arange(all_cte_predset.shape[0]), cte_targets].mean()
    print(f"The empirical coverage for CTE is: {empirical_coverage_cte:.3f}")

    empirical_coverage_he = all_he_predset[np.arange(all_he_predset.shape[0]), he_targets].mean()
    print(f"The empirical coverage for HE is: {empirical_coverage_he:.3f}")
    
    return all_cte_predset, all_he_predset, cte_targets, he_targets

def create_confusion_matrices(cte_preds, he_preds, cte_targets, he_targets, output_dir):
    """Create and save confusion matrices"""
    # Define class names
    cte_class_names = ['Extreme Left', 'Left', 'Middle', 'Right', 'Extreme Right']
    he_class_names = ['Left', 'Straight', 'Right']
    
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

def create_conformalization_csv(cte_predsets, he_predsets, cte_targets, he_targets, output_dir):
    """Create and save CSV files"""
    N1, C1 = cte_predsets.shape

    # Create a Pandas DataFrame with columns for each class in prediction_sets
    df_cte_predsets = pd.DataFrame(cte_predsets, 
                            columns=[f"cte{i}" for i in range(C1)])

    # 2) Insert a column for true_label at the front (column 0)
    df_cte_predsets.insert(0, "cte", cte_targets)

    # 3) Save to CSV (no index column)
    df_cte_predsets.to_csv(os.path.join(output_dir,"cte_pred_sets.csv"), index=False)

    print("Saved CTE prediction sets as CSV with shape:", df_cte_predsets.shape)
    print(df_cte_predsets.head())

    N2, C2 = he_predsets.shape

    # Create a Pandas DataFrame with columns for each class in prediction_sets
    df_he_predsets = pd.DataFrame(he_predsets, 
                            columns=[f"he{i}" for i in range(C2)])

    # 2) Insert a column for true_label at the front (column 0)
    df_he_predsets.insert(0, "he", he_targets)

    # 3) Save to CSV (no index column)
    df_he_predsets.to_csv(os.path.join(output_dir,"he_pred_sets.csv"), index=False)

    print("Saved HE prediction sets as CSV with shape:", df_he_predsets.shape)
    print(df_he_predsets.head())


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
    cte_labels = ['Extreme Left', 'Left', 'Middle', 'Right', 'Extreme Right']
    he_labels = ['Left', 'Straight', 'Right']
    
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
    parser.add_argument('--data_indices_dir', type=str, required=True, help='Directory containing data indices')
    parser.add_argument('--output_dir', type=str, default='./results', help='Directory to save results')
    parser.add_argument('--batch_size', type=int, default=32, help='Batch size')
    parser.add_argument('--num_samples', type=int, default=None, help='Number of samples to use (set to 0 for all)')
    parser.add_argument('--max_files', type=int, default=None, help='Maximum number of files to use for testing')
    parser.add_argument('--use_cpu', action='store_true', help='Force CPU usage')
    parser.add_argument('--conformalize', action='store_true', help='Conformalize model')
    parser.add_argument('--alpha', type=float, default=0.1, help='Conformalization coverage parameter')
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
    dataset = RobotNavigationDataset(
        args.data_dir, 
        transform=None,  # Use default transformation
        max_files=args.max_files,
        sample_limit=args.num_samples
    )

    test_indices = torch.load(os.path.join(args.data_indices_dir, 'test_indices.pt'))
    test_dataset = Subset(dataset, test_indices)
    
    # Create test dataloader
    test_loader = torch.utils.data.DataLoader(
        test_dataset,
        batch_size=args.batch_size,
        shuffle=False,
        num_workers=4
    )

    if args.conformalize:
        # Create calibration dataset
        cal_indices   = torch.load(os.path.join(args.data_indices_dir, 'cal_indices.pt'))
        cal_dataset   = Subset(dataset, cal_indices)
        
        # Create calibration dataloader
        cal_loader = torch.utils.data.DataLoader(
            cal_dataset,
            batch_size=args.batch_size,
            shuffle=False,
            num_workers=4
        )

        # Conformalize model
        cte_predsets, he_predsets, cte_targets, he_targets = conformalize_model(model, test_loader, cal_loader,
                                                                           args.alpha, device)
        print("Creating CSV files with conformalization results...")
        create_conformalization_csv(cte_predsets, he_predsets, cte_targets, he_targets, args.output_dir)
        
    
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
        target_names=['Extreme Left', 'Left', 'Middle', 'Right', 'Extreme Right']
    )
    print(cte_report)
    
    print("\nHE Classification Report:")
    he_report = classification_report(
        he_targets, he_preds,
         target_names=['Left', 'Straight', 'Right']
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