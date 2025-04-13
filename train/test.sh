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
# module load Python/3.10.8-GCCcore-12.2.0

# Activate virtual environment
# source ~/pytorch_env/bin/activate

# Create directories if they don't exist
mkdir -p logs models results

# Print environment info
echo "Job started at $(date)"
echo "Python version: $(python --version 2>&1)"
echo "PyTorch version: $(python -c 'import torch; print(torch.__version__)')"

# Run the testing script
python test_model_modified_bins.py \
    --model_path=./models/best_model.pth \
    --data_dir=../data/taxinet/ \
    --data_indices_dir=./models \
    --output_dir=./results \
    --batch_size=128 \
    --conformalize \
    --alpha=0.05

echo "Job finished at $(date)"
