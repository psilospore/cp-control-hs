import torch
import torch.nn as nn
import torch.nn.functional as F
import torchvision.models as models

# Constants for discretization
CTE_BINS = 3  # left, middle, right
HE_BINS = 5   # extreme left, left, straight, right, extreme right

class RobotNavigationModel(nn.Module):

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
        
        # CTE classification branch
        self.cte_head = nn.Sequential(
            nn.Linear(256, 128),
            nn.ReLU(),
            nn.Linear(128, CTE_BINS)
        )
        
        # HE classification branch
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
