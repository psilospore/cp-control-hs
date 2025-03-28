#!/bin/bash
#SBATCH --job-name=mod_bins
#SBATCH --output=logs/mod_bins_%j.out
#SBATCH --error=logs/mod_bins_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH --time=12:00:00

# Load Python module
module load Python/3.10.8-GCCcore-12.2.0

# Activate virtual environment
source ~/pytorch_env/bin/activate

# Create directories if they don't exist
mkdir -p logs models_modified results_modified

# Print environment info
echo "Job started at $(date)"
echo "Python version: $(python --version 2>&1)"
echo "PyTorch version: $(python -c 'import torch; print(torch.__version__)')"

# Run the training script with modified bins
python train_modified_bins.py \
    --data_dir=/users/pfp525/CPModel/data \
    --output_dir=./models_modified \
    --log_dir=./logs \
    --batch_size=16 \
    --epochs=50 \
    --lr=0.001 \
    --max_files=10 \
    --sample_limit=1000

echo "Training completed at $(date)"

# Once training is complete, run the testing script
python test_model_modified_bins.py \
    --model_path=./models_modified/best_model.pth \
    --data_dir=/users/pfp525/CPModel/data \
    --output_dir=./results_modified \
    --batch_size=16 \
    --max_files=20 \
    --use_cpu

echo "Job finished at $(date)"