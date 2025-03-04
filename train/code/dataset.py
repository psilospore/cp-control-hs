import numpy as np
import torch
from torch.utils.data import Dataset, DataLoader
import torchvision.transforms as transforms
import math

CTE_BINS = 3  # left, middle, right
HE_BINS = 5   # extreme left, left, straight, right, extreme right

class RobotNavigationDataset(Dataset):
    
    def __init__(self, data_file, transform=None, train=True):
        """
        Args:
            data_file (str): Path to .npz data file
            transform (callable, optional): Transform to apply to images
            train (bool): Whether this is training data (affects augmentation)
        """
        # Load data
        data = np.load(data_file)
        self.images = data['images']
        labels = data['labels']
        
        # Extract CTE and HE from labels
        self.cte_values = labels[:, 0]  # x-coordinate
        theta_values = labels[:, 1]     # heading
        self.he_values = 0.5 * np.pi - theta_values  # heading error
        
        # Discretize CTE into 3 bins
        cte_bins = [-0.55, -0.18, 0.18, 0.55]
        self.cte_categories = np.digitize(self.cte_values, cte_bins[1:-1])  # returns 0, 1, or 2
        
        # Discretize HE into 5 bins
        he_bins = [-0.25*np.pi, -0.15*np.pi, -0.05*np.pi, 0.05*np.pi, 0.15*np.pi, 0.25*np.pi]
        self.he_categories = np.digitize(self.he_values, he_bins[1:-1])  # returns 0-4
        
        # Set up transformations
        if transform is None:
            if train:
                self.transform = transforms.Compose([
                    transforms.ToPILImage(),
                    transforms.ColorJitter(brightness=0.1, contrast=0.1),
                    transforms.ToTensor(),
                    transforms.Normalize(mean=[0.485, 0.456, 0.406], 
                                        std=[0.229, 0.224, 0.225])
                ])
            else:
                self.transform = transforms.Compose([
                    transforms.ToPILImage(),
                    transforms.ToTensor(),
                    transforms.Normalize(mean=[0.485, 0.456, 0.406], 
                                        std=[0.229, 0.224, 0.225])
                ])
        else:
            self.transform = transform
    
    def __len__(self):
        return len(self.images)
    
    def __getitem__(self, idx):
        # Get image and convert to float
        image = self.images[idx].astype(np.float32) / 255.0
        
        # Apply transformations
        if self.transform:
            image = self.transform(image)
        
        # Get labels
        cte_category = self.cte_categories[idx]
        he_category = self.he_categories[idx]
        
        return image, cte_category, he_category

def create_data_loaders(data_file, batch_size=32, train_ratio=0.8, val_ratio=0.1, 
                       num_workers=4, distributed=False):
    """
    Create train, validation, and test data loaders
    
    Args:
        data_file (str): Path to .npz data file
        batch_size (int): Batch size
        train_ratio (float): Ratio of data to use for training
        val_ratio (float): Ratio of data to use for validation
        num_workers (int): Number of workers for data loading
        distributed (bool): Whether to use DistributedSampler
    
    Returns:
        tuple: (train_loader, val_loader, test_loader)
    """
    # Load all data to calculate dataset size
    data = np.load(data_file)
    dataset_size = len(data['images'])
    
    # Calculate split indices
    train_size = int(dataset_size * train_ratio)
    val_size = int(dataset_size * val_ratio)
    test_size = dataset_size - train_size - val_size
    
    # Create indices for each split
    indices = list(range(dataset_size))
    np.random.shuffle(indices)
    train_indices = indices[:train_size]
    val_indices = indices[train_size:train_size+val_size]
    test_indices = indices[train_size+val_size:]
    
    # Create datasets
    full_dataset = RobotNavigationDataset(data_file, train=True)
    test_dataset = RobotNavigationDataset(data_file, train=False)
    
    # Create samplers
    if distributed:
        from torch.utils.data.distributed import DistributedSampler
        train_sampler = DistributedSampler(
            full_dataset, 
            num_replicas=torch.distributed.get_world_size(),
            rank=torch.distributed.get_rank(),
            shuffle=True
        )
        val_sampler = DistributedSampler(
            full_dataset,
            num_replicas=torch.distributed.get_world_size(),
            rank=torch.distributed.get_rank(),
            shuffle=False
        )
        test_sampler = DistributedSampler(
            test_dataset,
            num_replicas=torch.distributed.get_world_size(),
            rank=torch.distributed.get_rank(),
            shuffle=False
        )
    else:
        from torch.utils.data import SubsetRandomSampler
        train_sampler = SubsetRandomSampler(train_indices)
        val_sampler = SubsetRandomSampler(val_indices)
        test_sampler = SubsetRandomSampler(test_indices)
    
    # Create data loaders
    train_loader = DataLoader(
        full_dataset, 
        batch_size=batch_size,
        sampler=train_sampler,
        num_workers=num_workers,
        pin_memory=True
    )
    
    val_loader = DataLoader(
        full_dataset, 
        batch_size=batch_size,
        sampler=val_sampler,
        num_workers=num_workers,
        pin_memory=True
    )
    
    test_loader = DataLoader(
        test_dataset, 
        batch_size=batch_size,
        sampler=test_sampler,
        num_workers=num_workers,
        pin_memory=True
    )
    
    return train_loader, val_loader, test_loader, train_sampler
