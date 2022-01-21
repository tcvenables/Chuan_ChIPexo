#!/bin/bash
#SBATCH --nodes=1
#SBATCH --mem=24gb
#SBATCH --ntasks=16

cd $SLURM_SUBMIT_DIR

module load bowtie2
bowtie2 -p 15 -x HumanJurkatHivIntNew/HumanHIVchr15intNew_index --no-mixed --no-discordant --dovetail -1 474-1_R1_cat -2 474-1_R2_cat -S 474_1_refseqHIVintNew.sam


