#!/bin/bash
#SBATCH --mem=10G
#SBATCH --cpus-per-task=4
#SBATCH --error=/share/RM_SLURM/step2.%A_%a.error 
#SBATCH --output=/share/RM_SLURM/step2.%A_%a.out 
#SBATCH --workdir=/share/RM_SLURM
#SBATCH --array=1-30

module load checkpoint
module load ncbi-blast 
module load repeatmasker
set -x
 bash  /share/RM_SCRIPTS/step2_script.sh $1
