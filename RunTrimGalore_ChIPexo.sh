#!/bin/bash
#SBATCH --nodes=1
#SBATCH --mem=16gb
#SBATCH --ntasks=16

cd $SLURM_SUBMIT_DIR

module load trimgalore

FastqFiles=( $(ls ./ 408-5*R1*fastq) )

for r1 in ${FastqFiles[@]}; do
    r2=${r1/R1/R2}
    trim_galore -trim-n -j 10 -a2 G{10} --paired $r1 $r2
done

