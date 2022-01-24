#!/bin/bash
#SBATCH --nodes=1
#SBATCH --mem=4gb
#SBATCH --ntasks=1

cd $SLURM_SUBMIT_DIR
module load samtools
module load macs/2.1.0


BamFiles=( $(ls GSM*ChrSort.bam) )
for b1 in ${BamFiles[@]}; do
bam2name=${b1/bam/ChrSort.bam}
macsname=${bam2name/.bam/MACS}
samtools sort -o $bam2name -O bam $b1
macs2 callpeak -t $bam2name --broad -f BAM -g hs -n $macsname -q 0.05 -B --nomodel 
done

