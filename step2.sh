#!/bin/bash
#SBATCH --mem=10G
#SBATCH --cpus-per-task=4
#SBATCH --error=/share/RM_SLURM/step2.%A_%a.error 
#SBATCH --output=/share/RM_SLURM/step2.%A_%a.out 
#SBATCH --workdir=/share/RM_SLURM
#SBATCH --array=1-30

SCRIPT_DIRECTORY=/share/RM_SCRIPTS
set -x
bash  $SCRIPT_DIRECTORY/step2_script.sh $1 $2 $3
