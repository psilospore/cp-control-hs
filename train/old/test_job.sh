#!/bin/bash
#SBATCH --job-name=test_nav
#SBATCH --output=logs/test_nav_%j.out
#SBATCH --error=logs/test_nav_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH --time=2:00:00

# Load Python module
module load Python/3.10.8-GCCcore-12.2.0

# Activate virtual environment
source ~/pytorch_env/bin/activate

# Create directories if they don't exist
mkdir -p results

# Print environment info
echo "Job started at $(date)"
echo "Python version: $(python --version 2>&1)"
echo "PyTorch version: $(python -c 'import torch; print(torch.__version__)')"

# Run the testing script
python test_model.py \
    --model_path=./models/best_model.pth \
    --data_dir=/users/pfp525/CPModel/data \
    --output_dir=./results \
    --batch_size=16 \
    --max_files=20 \
    --use_cpu

echo "Job finished at $(date)"