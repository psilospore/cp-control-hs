import os
import sys
import subprocess

def main():
    # Get number of GPUs
    num_gpus = torch.cuda.device_count()
    print(f"Found {num_gpus} GPUs")
    
    if num_gpus < 2:
        print("Warning: Less than 2 GPUs detected. Will run on single GPU.")
    
    # Launch distributed training
    cmd = [
        sys.executable, "-m", "torch.distributed.launch",
        f"--nproc_per_node={num_gpus}",
        "train.py",
    ] + sys.argv[1:]
    
    print(f"Launching command: {' '.join(cmd)}")
    subprocess.run(cmd)

if __name__ == "__main__":
    import torch
    main()
