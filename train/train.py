import os
import glob
import argparse
import time
import numpy as np
import torch
import torch.nn as nn
import torch.optim as optim
from torch.utils.data import DataLoader, Dataset, random_split
import torchvision.models as models
from torchvision import transforms
import gc  # Garbage collection

# Constants for discretization - UPDATED BINS
CTE_BINS = 5  # extreme left, left, middle, right, extreme right
HE_BINS = 3   # left, straight, right

class RobotNavigationDataset(Dataset):
    """Memory-efficient dataset for robot navigation using file indices"""
    
    def __init__(self, data_dir, transform=None, pattern="data_*.npz", max_files=None, sample_limit=None):
        """
        Args:
            data_dir (str): Path to directory containing .npz data files
            transform (callable, optional): Transform to apply to images
            pattern (str): File pattern to match
            max_files (int, optional): Maximum number of files to load
            sample_limit (int, optional): Maximum number of samples to use
        """
        self.data_dir = data_dir
        self.transform = transform
        
        # Find all npz files in the directory
        self.data_files = sorted(glob.glob(os.path.join(data_dir, pattern)))
        if not self.data_files:
            raise FileNotFoundError(f"No files matching '{pattern}' found in {data_dir}")
        
        # Limit the number of files if specified
        if max_files is not None and max_files > 0:
            self.data_files = self.data_files[:max_files]
            
        print(f"Found {len(self.data_files)} data files.")
        
        # Pre-compute dataset size without loading all data
        self.file_stats = []
        total_samples = 0
        
        for file_path in self.data_files:
            try:
                # Load only the metadata and not the actual arrays
                with np.load(file_path, mmap_mode='r') as data:
                    if 'images' in data and 'labels' in data:
                        n_samples = len(data['images'])
                        self.file_stats.append({
                            'path': file_path,
                            'n_samples': n_samples,
                            'start_idx': total_samples
                        })
                        total_samples += n_samples
            except Exception as e:
                print(f"Error checking {file_path}: {e}")
        
        self.total_samples = total_samples
        
        # Apply sample limit if specified
        if sample_limit is not None and sample_limit > 0:
            self.total_samples = min(sample_limit, self.total_samples)
        
        print(f"Total dataset size: {self.total_samples} samples")
        
        # Set up default transform if none provided
        if self.transform is None:
            self.transform = transforms.Compose([
                transforms.ToTensor(),
                transforms.Normalize(mean=[0.485, 0.456, 0.406], 
                                    std=[0.229, 0.224, 0.225])
            ])
    
    def __len__(self):
        return self.total_samples
    
    def __getitem__(self, idx):
        if idx >= self.total_samples:
            raise IndexError(f"Index {idx} out of bounds for dataset with {self.total_samples} samples")
        
        # Find which file contains this index
        file_info = None
        local_idx = idx
        
        for i, stats in enumerate(self.file_stats):
            if i == len(self.file_stats) - 1 or idx < self.file_stats[i+1]['start_idx']:
                file_info = stats
                local_idx = idx - stats['start_idx']
                break
        
        # Load just this one sample from the file
        with np.load(file_info['path'], mmap_mode='r') as data:
            # Extract the individual image and label
            image = data['images'][local_idx].astype(np.float32) / 255.0
            label = data['labels'][local_idx]
        
        # Process CTE and HE values
        cte_value = label[0]
        theta_value = label[1]
        he_value = 0.5 * np.pi - theta_value
        
        # UPDATED: Discretize CTE into 5 bins
        cte_bins = [-0.55, -0.33, -0.11, 0.11, 0.33, 0.55]
        cte_category = np.digitize([cte_value], cte_bins[1:-1])[0]
        
        # UPDATED: Discretize HE into 3 bins
        he_bins = [-0.25*np.pi, -0.05*np.pi, 0.05*np.pi, 0.25*np.pi]
        he_category = np.digitize([he_value], he_bins[1:-1])[0]
        
        # Convert to tensor and normalize
        image = torch.tensor(image).permute(2, 0, 1)  # Convert to CxHxW format
        
        return image, cte_category, he_category

class RobotNavigationModel(nn.Module):
    """
    PyTorch model for robot navigation prediction using MobileNetV2 backbone
    """
    def __init__(self, pretrained=True):
        super(RobotNavigationModel, self).__init__()
        
        # Load MobileNetV2 as backbone
        self.backbone = models.mobilenet_v2(pretrained=pretrained)
        
        # Remove the classifier
        self.features = nn.Sequential(*list(self.backbone.children())[:-1])
        
        # Define feature dimension after backbone
        self.feature_dim = 1280
        
        # Common layers
        self.common = nn.Sequential(
            nn.Dropout(0.3),
            nn.Linear(self.feature_dim, 512),
            nn.ReLU(),
            nn.BatchNorm1d(512),
            nn.Dropout(0.3),
            nn.Linear(512, 256),
            nn.ReLU(),
            nn.BatchNorm1d(256)
        )
        
        # CTE classification branch - Now outputs 5 classes
        self.cte_head = nn.Sequential(
            nn.Linear(256, 128),
            nn.ReLU(),
            nn.Linear(128, CTE_BINS)
        )
        
        # HE classification branch - Now outputs 3 classes
        self.he_head = nn.Sequential(
            nn.Linear(256, 128),
            nn.ReLU(),
            nn.Linear(128, HE_BINS)
        )
    
    def forward(self, x):
        """Forward pass through the network"""
        # Feature extraction
        x = self.features(x)
        
        # Global average pooling (equivalent to GlobalAveragePooling2D in TF)
        x = x.mean([2, 3])
        
        # Common layers
        x = self.common(x)
        
        # Branch-specific outputs
        cte_logits = self.cte_head(x)
        he_logits = self.he_head(x)
        
        return cte_logits, he_logits

def train(args):
    # Set device - use CPU or GPU if available
    device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
    print(f"Using device: {device}")
    
    # Create directories for outputs
    os.makedirs(args.output_dir, exist_ok=True)
    os.makedirs(args.log_dir, exist_ok=True)
    
    # Load dataset - memory efficient version
    print(f"Loading dataset from directory: {args.data_dir}")
    dataset = RobotNavigationDataset(
        args.data_dir, 
        max_files=args.max_files, 
        sample_limit=args.sample_limit
    )
    
    # Split dataset into train, validation, calibration, and test
    train_size = int(0.6 * len(dataset))
    val_size = int(0.1 * len(dataset))
    cal_size = int(0.15 * len(dataset))
    test_size = len(dataset) - (train_size + val_size + cal_size)
    train_dataset, val_dataset, cal_dataset, test_dataset = random_split(dataset, [train_size, val_size, cal_size, test_size])
    
    torch.save(train_dataset.indices, os.path.join(args.output_dir, 'train_indices.pt'))
    torch.save(val_dataset.indices, os.path.join(args.output_dir, 'val_indices.pt'))
    torch.save(cal_dataset.indices, os.path.join(args.output_dir, 'cal_indices.pt'))
    torch.save(test_dataset.indices, os.path.join(args.output_dir, 'test_indices.pt'))

    # Create data loaders with smaller num_workers
    train_loader = DataLoader(
        train_dataset, 
        batch_size=args.batch_size, 
        shuffle=True,
        num_workers=4,  # Reduced to save memory
        pin_memory=False  # Set to False to reduce memory usage
    )
    
    val_loader = DataLoader(
        val_dataset, 
        batch_size=args.batch_size, 
        shuffle=False,
        num_workers=4,  # Reduced to save memory
        pin_memory=False  # Set to False to reduce memory usage
    )
    
    # Clear memory before creating model
    gc.collect()
    
    # Create model
    model = RobotNavigationModel(pretrained=True)
    model.to(device)
    
    # Define loss function and optimizer
    criterion = nn.CrossEntropyLoss()
    optimizer = optim.Adam(model.parameters(), lr=args.lr)
    
    # Learning rate scheduler
    scheduler = optim.lr_scheduler.ReduceLROnPlateau(
        optimizer, mode='min', factor=0.1, patience=5, verbose=True
    )
    
    # Training loop
    print(f"Starting training for {args.epochs} epochs")
    best_val_loss = float('inf')
    
    for epoch in range(args.epochs):
        # Training phase
        model.train()
        train_loss = 0.0
        train_cte_correct = 0
        train_he_correct = 0
        
        # Track batch progress
        batch_count = 0
        total_batches = len(train_loader)
        
        for images, cte_targets, he_targets in train_loader:
            # Move to device
            images = images.to(device)
            cte_targets = cte_targets.to(device)
            he_targets = he_targets.to(device)
            
            # Zero the gradients
            optimizer.zero_grad()
            
            # Forward pass
            cte_outputs, he_outputs = model(images)
            
            # Calculate loss
            cte_loss = criterion(cte_outputs, cte_targets)
            he_loss = criterion(he_outputs, he_targets)
            loss = cte_loss + he_loss
            
            # Backward pass and optimize
            loss.backward()
            optimizer.step()
            
            # Track statistics
            batch_size = images.size(0)
            train_loss += loss.item() * batch_size
            _, cte_preds = torch.max(cte_outputs, 1)
            _, he_preds = torch.max(he_outputs, 1)
            train_cte_correct += (cte_preds == cte_targets).sum().item()
            train_he_correct += (he_preds == he_targets).sum().item()
            
            # Print batch progress
            batch_count += 1
            if batch_count % 5 == 0:
                print(f"Epoch {epoch+1}, Batch {batch_count}/{total_batches} complete")
            
            # Free up memory
            del images, cte_targets, he_targets, cte_outputs, he_outputs
            gc.collect()
        
        # Calculate epoch statistics
        train_loss = train_loss / len(train_loader.dataset)
        train_cte_acc = train_cte_correct / len(train_loader.dataset)
        train_he_acc = train_he_correct / len(train_loader.dataset)
        
        # Validation phase
        model.eval()
        val_loss = 0.0
        val_cte_correct = 0
        val_he_correct = 0
        
        with torch.no_grad():
            for images, cte_targets, he_targets in val_loader:
                # Move to device
                images = images.to(device)
                cte_targets = cte_targets.to(device)
                he_targets = he_targets.to(device)
                
                # Forward pass
                cte_outputs, he_outputs = model(images)
                
                # Calculate loss
                cte_loss = criterion(cte_outputs, cte_targets)
                he_loss = criterion(he_outputs, he_targets)
                loss = cte_loss + he_loss
                
                # Track statistics
                batch_size = images.size(0)
                val_loss += loss.item() * batch_size
                _, cte_preds = torch.max(cte_outputs, 1)
                _, he_preds = torch.max(he_outputs, 1)
                val_cte_correct += (cte_preds == cte_targets).sum().item()
                val_he_correct += (he_preds == he_targets).sum().item()
                
                # Free up memory
                del images, cte_targets, he_targets, cte_outputs, he_outputs
                gc.collect()
        
        # Calculate epoch statistics
        val_loss = val_loss / len(val_loader.dataset)
        val_cte_acc = val_cte_correct / len(val_loader.dataset)
        val_he_acc = val_he_correct / len(val_loader.dataset)
        
        # Update learning rate
        scheduler.step(val_loss)
        
        # Print statistics
        print(f"Epoch {epoch+1}/{args.epochs} | "
              f"Train Loss: {train_loss:.4f} | "
              f"Train CTE Acc: {train_cte_acc:.4f} | "
              f"Train HE Acc: {train_he_acc:.4f} | "
              f"Val Loss: {val_loss:.4f} | "
              f"Val CTE Acc: {val_cte_acc:.4f} | "
              f"Val HE Acc: {val_he_acc:.4f}")
        
        # Save model if it's the best so far
        if val_loss < best_val_loss:
            best_val_loss = val_loss
            torch.save(model.state_dict(), os.path.join(args.output_dir, 'best_model.pth'))
            print(f"Saved new best model with validation loss: {val_loss:.4f}")
    
    print("Training complete!")
    return model

def main():
    parser = argparse.ArgumentParser(description='Train robot navigation model')
    parser.add_argument('--data_dir', type=str, required=True, help='Directory containing data files')
    parser.add_argument('--output_dir', type=str, default='../models', help='Directory to save models and data indices')
    parser.add_argument('--log_dir', type=str, default='../logs', help='Directory to save logs')
    parser.add_argument('--batch_size', type=int, default=32, help='Batch size')
    parser.add_argument('--epochs', type=int, default=50, help='Number of epochs')
    parser.add_argument('--lr', type=float, default=0.001, help='Learning rate')
    parser.add_argument('--max_files', type=int, default=None, help='Maximum number of files to load')
    parser.add_argument('--sample_limit', type=int, default=None, help='Maximum number of samples to use')
    args = parser.parse_args()
    
    train(args)

if __name__ == '__main__':
    main()