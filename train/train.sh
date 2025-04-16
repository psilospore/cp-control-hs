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
#module load Python/3.10.8-GCCcore-12.2.0

# Activate virtual environment
#source ~/pytorch_env/bin/activate

# Create directories if they don't exist
mkdir -p logs models results

# Print environment info
echo "Job started at $(date)"
echo "Python version: $(python --version 2>&1)"
echo "PyTorch version: $(python -c 'import torch; print(torch.__version__)')"

# Run the training script with modified bins
python train.py \
   --data_dir=../data/taxinet/ \
   --output_dir=./models \
   --log_dir=./logs \
   --batch_size=128 \
   --epochs=50 \
   --lr=0.001

echo "Training completed at $(date)"
echo "Job finished at $(date)"
