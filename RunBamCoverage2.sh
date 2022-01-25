#!/bin/bash
#SBATCH --nodes=1
#SBATCH --mem=24gb
#SBATCH --ntasks=16

cd $SLURM_SUBMIT_DIR
module load python
module load samtools 
BamFiles=( $(ls SRR11*22Jan2022*bam) )
for b1 in ${BamFiles[@]}; do
BigWigName=${b1/.bam/.bw}
samtools index $b1 
bamCoverage -b $b1 -o $BigWigName -p 6   
done
