import os
import argparse
import time
import datetime
import numpy as np
import torch
import torch.nn as nn
import torch.optim as optim
from torch.utils.data import DataLoader, random_split

from model import RobotNavigationModel
from dataset import RobotNavigationDataset

def parse_args():
    parser = argparse.ArgumentParser(description='Train robot navigation model (Single GPU)')
    parser.add_argument('--data_path', type=str, required=True, help='Path to npz data file')
    parser.add_argument('--output_dir', type=str, default='../models', help='Directory to save model')
    parser.add_argument('--log_dir', type=str, default='../logs', help='Directory for logs')
    parser.add_argument('--batch_size', type=int, default=32, help='Batch size')
    parser.add_argument('--epochs', type=int, default=50, help='Number of epochs')
    parser.add_argument('--lr', type=float, default=0.001, help='Initial learning rate')
    parser.add_argument('--weight_decay', type=float, default=1e-4, help='Weight decay')
    parser.add_argument('--seed', type=int, default=42, help='Random seed')
    return parser.parse_args()

def train_one_epoch(model, train_loader, criterion, optimizer, device):
    """Train for one epoch"""
    model.train()
    running_loss = 0.0
    running_cte_acc = 0.0
    running_he_acc = 0.0
    
    start_time = time.time()
    for batch_idx, (images, cte_targets, he_targets) in enumerate(train_loader):
        # Move data to device
        images = images.to(device)
        cte_targets = cte_targets.to(device)
        he_targets = he_targets.to(device)
        
        # Zero the parameter gradients
        optimizer.zero_grad()
        
        # Forward + backward + optimize
        cte_outputs, he_outputs = model(images)
        cte_loss = criterion(cte_outputs, cte_targets)
        he_loss = criterion(he_outputs, he_targets)
        loss = cte_loss + he_loss
        
        loss.backward()
        optimizer.step()
        
        # Calculate accuracies
        _, cte_preds = torch.max(cte_outputs, 1)
        _, he_preds = torch.max(he_outputs, 1)
        cte_correct = (cte_preds == cte_targets).float().sum()
        he_correct = (he_preds == he_targets).float().sum()
        
        # Update running statistics
        running_loss += loss.item() * images.size(0)
        running_cte_acc += cte_correct
        running_he_acc += he_correct
        
        # Print statistics for every 10 batches
        if batch_idx % 10 == 0:
            print(f'Batch: {batch_idx}/{len(train_loader)} | '
                  f'Loss: {loss.item():.4f} | '
                  f'CTE Acc: {cte_correct / len(images):.4f} | '
                  f'HE Acc: {he_correct / len(images):.4f}')
    
    # Get epoch statistics
    dataset_size = len(train_loader.dataset)
    epoch_loss = running_loss / dataset_size
    epoch_cte_acc = running_cte_acc / dataset_size
    epoch_he_acc = running_he_acc / dataset_size
    epoch_time = time.time() - start_time
    
    return epoch_loss, epoch_cte_acc, epoch_he_acc, epoch_time

def validate(model, val_loader, criterion, device):
    """Validate the model"""
    model.eval()
    val_loss = 0.0
    val_cte_correct = 0
    val_he_correct = 0
    
    with torch.no_grad():
        for images, cte_targets, he_targets in val_loader:
            # Move data to device
            images = images.to(device)
            cte_targets = cte_targets.to(device)
            he_targets = he_targets.to(device)
            
            # Forward pass
            cte_outputs, he_outputs = model(images)
            cte_loss = criterion(cte_outputs, cte_targets)
            he_loss = criterion(he_outputs, he_targets)
            loss = cte_loss + he_loss
            
            # Calculate accuracies
            _, cte_preds = torch.max(cte_outputs, 1)
            _, he_preds = torch.max(he_outputs, 1)
            val_cte_correct += (cte_preds == cte_targets).sum().item()
            val_he_correct += (he_preds == he_targets).sum().item()
            
            # Update statistics
            val_loss += loss.item() * images.size(0)
    
    # Get validation statistics
    dataset_size = len(val_loader.dataset)
    val_loss /= dataset_size
    val_cte_acc = val_cte_correct / dataset_size
    val_he_acc = val_he_correct / dataset_size
    
    return val_loss, val_cte_acc, val_he_acc

def main():
    # Parse arguments
    args = parse_args()
    
    # Set device
    device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
    print(f"Using device: {device}")
    
    # Set random seed for reproducibility
    torch.manual_seed(args.seed)
    if torch.cuda.is_available():
        torch.cuda.manual_seed(args.seed)
    
    # Create output directories
    os.makedirs(args.output_dir, exist_ok=True)
    os.makedirs(args.log_dir, exist_ok=True)
    
    # Create log file
    timestamp = datetime.datetime.now().strftime("%Y%m%d-%H%M%S")
    log_file = os.path.join(args.log_dir, f'training_log_{timestamp}.txt')
    
    with open(log_file, 'w') as f:
        f.write(f"Training started at {timestamp}\n")
        f.write(f"Arguments: {args}\n\n")
        f.write("Epoch,TrainLoss,TrainCTEAcc,TrainHEAcc,ValLoss,ValCTEAcc,ValHEAcc,LR,Time\n")
    
    # Load and prepare dataset
    print(f"Loading dataset from {args.data_path}")
    full_dataset = RobotNavigationDataset(args.data_path, train=True)
    
    # Split dataset
    dataset_size = len(full_dataset)
    train_size = int(dataset_size * 0.8)
    val_size = dataset_size - train_size
    
    train_dataset, val_dataset = random_split(full_dataset, [train_size, val_size])
    
    train_loader = DataLoader(train_dataset, batch_size=args.batch_size, shuffle=True, num_workers=4, pin_memory=True)
    val_loader = DataLoader(val_dataset, batch_size=args.batch_size, shuffle=False, num_workers=4, pin_memory=True)
    
    print(f"Training samples: {len(train_dataset)}")
    print(f"Validation samples: {len(val_dataset)}")
    
    # Create model
    model = RobotNavigationModel(pretrained=True)
    model.to(device)
    
    # Define loss function and optimizer
    criterion = nn.CrossEntropyLoss()
    optimizer = optim.Adam(model.parameters(), lr=args.lr, weight_decay=args.weight_decay)
    
    # Learning rate scheduler
    scheduler = optim.lr_scheduler.ReduceLROnPlateau(
        optimizer, mode='min', factor=0.1, patience=5, verbose=True
    )
    
    # Training loop
    best_val_loss = float('inf')
    for epoch in range(1, args.epochs + 1):
        # Train for one epoch
        train_loss, train_cte_acc, train_he_acc, epoch_time = train_one_epoch(
            model, train_loader, criterion, optimizer, device
        )
        
        # Validate
        val_loss, val_cte_acc, val_he_acc = validate(model, val_loader, criterion, device)
        
        # Update learning rate
        scheduler.step(val_loss)
        current_lr = optimizer.param_groups[0]['lr']
        
        # Print epoch results
        print(f'\nEpoch: {epoch}/{args.epochs} | '
              f'Train Loss: {train_loss:.4f} | '
              f'Train CTE Acc: {train_cte_acc:.4f} | '
              f'Train HE Acc: {train_he_acc:.4f} | '
              f'Val Loss: {val_loss:.4f} | '
              f'Val CTE Acc: {val_cte_acc:.4f} | '
              f'Val HE Acc: {val_he_acc:.4f} | '
              f'LR: {current_lr:.6f} | '
              f'Time: {epoch_time:.2f}s\n')
        
        # Save log
        with open(log_file, 'a') as f:
            f.write(f"{epoch},{train_loss:.6f},{train_cte_acc:.4f},{train_he_acc:.4f},"
                    f"{val_loss:.6f},{val_cte_acc:.4f},{val_he_acc:.4f},{current_lr:.6f},{epoch_time:.2f}\n")
        
        # Save checkpoint
        checkpoint = {
            'epoch': epoch,
            'model_state_dict': model.state_dict(),
            'optimizer_state_dict': optimizer.state_dict(),
            'scheduler_state_dict': scheduler.state_dict(),
            'train_loss': train_loss,
            'val_loss': val_loss,
            'train_cte_acc': train_cte_acc,
            'train_he_acc': train_he_acc,
            'val_cte_acc': val_cte_acc,
            'val_he_acc': val_he_acc,
        }
        
        # Save the latest model
        torch.save(checkpoint, os.path.join(args.output_dir, f'model_latest.pth'))
        
        # Save the best model
        if val_loss < best_val_loss:
            best_val_loss = val_loss
            torch.save(checkpoint, os.path.join(args.output_dir, f'model_best.pth'))
            print(f'Best model saved with validation loss: {val_loss:.6f}')

if __name__ == "__main__":
    main()