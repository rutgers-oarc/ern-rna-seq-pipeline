#!/bin/bash
#SBATCH --job-name=rna-seq-test
#SBATCH --time=00:20:00              # Total run time limit (HH:MM:SS)
#SBATCH --output=slurm.%N.%j.out     # STDOUT output file
#SBATCH --error=slurm.%N.%j.err      # STDERR output file (optional)

export PATH=$PATH:/usr/local/bin:.
/opt/ohpc/pub/libs/singularity/2.5.1/bin/singularity exec --bind /home:/home /home/bd387/simg-repo/rna-trans-align.simg ./job-rna-seq.sh
