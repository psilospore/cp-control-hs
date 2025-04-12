import os
import argparse
import numpy as np
import matplotlib.pyplot as plt
import torch
import torch.nn as nn
from sklearn.metrics import confusion_matrix, classification_report
import seaborn as sns

from model import RobotNavigationModel
from dataset import RobotNavigationDataset, create_data_loaders

def parse_args():
    parser = argparse.ArgumentParser(description='Evaluate robot navigation model')
    parser.add_argument('--model_path', type=str, required=True, help='Path to saved model')
    parser.add_argument('--data_path', type=str, required=True, help='Path to test data')
    parser.add_argument('--results_dir', type=str, default='../results', help='Directory to save results')
    parser.add_argument('--batch_size', type=int, default=32, help='Batch size for evaluation')
    return parser.parse_args()

def evaluate_model(model, data_loader, device):
    """Evaluate the model and collect predictions and targets"""
    model.eval()
    
    all_cte_preds = []
    all_he_preds = []
    all_cte_targets = []
    all_he_targets = []
    
    with torch.no_grad():
        for images, cte_targets, he_targets in data_loader:
            # Move data to device
            images = images.to(device)
            
            # Forward pass
            cte_outputs, he_outputs = model(images)
            
            # Get predictions
            _, cte_preds = torch.max(cte_outputs, 1)
            _, he_preds = torch.max(he_outputs, 1)
            
            # Collect predictions and targets
            all_cte_preds.extend(cte_preds.cpu().numpy())
            all_he_preds.extend(he_preds.cpu().numpy())
            all_cte_targets.extend(cte_targets.numpy())
            all_he_targets.extend(he_targets.numpy())
    
    return np.array(all_cte_preds), np.array(all_he_preds), np.array(all_cte_targets), np.array(all_he_targets)

def plot_confusion_matrices(cte_preds, he_preds, cte_targets, he_targets, results_dir):
    """Plot and save confusion matrices"""
    # Create confusion matrices
    cte_cm = confusion_matrix(cte_targets, cte_preds)
    he_cm = confusion_matrix(he_targets, he_preds)
    
    # Create figure
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(16, 6))
    
    # Plot CTE confusion matrix
    sns.heatmap(cte_cm, annot=True, fmt='d', cmap='Blues', ax=ax1)
    ax1.set_title('CTE Confusion Matrix')
    ax1.set_xlabel('Predicted')
    ax1.set_ylabel('True')
    ax1.set_xticklabels(['Left', 'Middle', 'Right'])
    ax1.set_yticklabels(['Left', 'Middle', 'Right'])
    
    # Plot HE confusion matrix
    sns.heatmap(he_cm, annot=True, fmt='d', cmap='Blues', ax=ax2)
    ax2.set_title('HE Confusion Matrix')
    ax2.set_xlabel('Predicted')
    ax2.set_ylabel('True')
    ax2.set_xticklabels(['Extreme Left', 'Left', 'Straight', 'Right', 'Extreme Right'])
    ax2.set_yticklabels(['Extreme Left', 'Left', 'Straight', 'Right', 'Extreme Right'])
    
    plt.tight_layout()
    
    # Create output directory if it doesn't exist
    os.makedirs(results_dir, exist_ok=True)
    
    # Save confusion matrix figure
    cm_path = os.path.join(results_dir, 'confusion_matrices.png')
    plt.savefig(cm_path)
    print(f"Confusion matrices saved to {cm_path}")
    
    return cte_cm, he_cm

def main():
    # Parse arguments
    args = parse_args()
    
    # Set device
    device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
    
    # Create data loaders
    _, _, test_loader, _ = create_data_loaders(
        args.data_path,
        batch_size=args.batch_size,
        train_ratio=0.8,
        val_ratio=0.1,
        num_workers=4,
        distributed=False
    )
    
    # Load model
    print(f"Loading model from {args.model_path}")
    checkpoint = torch.load(args.model_path, map_location=device)
    
    model = RobotNavigationModel(pretrained=False)
    
    # Handle both DDP and non-DDP model states
    if 'model_state_dict' in checkpoint:
        model.load_state_dict(checkpoint['model_state_dict'])
    else:
        model.load_state_dict(checkpoint)
    
    model.to(device)
    
    # Evaluate model
    print("Evaluating model...")
    cte_preds, he_preds, cte_targets, he_targets = evaluate_model(model, test_loader, device)
    
    # Plot and save confusion matrices
    cte_cm, he_cm = plot_confusion_matrices(cte_preds, he_preds, cte_targets, he_targets, args.results_dir)
    
    # Generate classification reports
    cte_report = classification_report(
        cte_targets, cte_preds,
        target_names=['Left', 'Middle', 'Right'],
        digits=4
    )
    
    he_report = classification_report(
        he_targets, he_preds,
        target_names=['Extreme Left', 'Left', 'Straight', 'Right', 'Extreme Right'],
        digits=4
    )
    
    # Print reports
    print("\nCTE Classification Report:")
    print(cte_report)
    print("\nHE Classification Report:")
    print(he_report)
    
    # Save reports
    report_path = os.path.join(args.results_dir, 'classification_reports.txt')
    with open(report_path, 'w') as f:
        f.write("CTE Classification Report:\n")
        f.write(cte_report)
        f.write("\n\nHE Classification Report:\n")
        f.write(he_report)
    
    print(f"Classification reports saved to {report_path}")

if __name__ == "__main__":
    main()
