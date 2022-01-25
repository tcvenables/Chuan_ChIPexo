#!/bin/bash
#SBATCH --nodes=1
#SBATCH --mem=24gb
#SBATCH --ntasks=16

cd $SLURM_SUBMIT_DIR
module load ucsc_tools

PileUpBdgs=( $( ls SRR118*22Jan2022*.bw ) )
for pu1 in ${PileUpBdgs[@]};do
bw1=${pu1/.bw/.bdg}
bigWigToBedGraph $pu1 $bw1
pu2=${bw1/.bdg/NORM.bdg}
pu3=${pu2/.bdg/sort.bdg}
pu4=${pu3/.bdg/.bw}
sf1=$(awk '{sum+=(($3-$2)*$4)} END {print sum}' $bw1)
sf2=$(awk "BEGIN {printf \"%.2f\n\", 948239572/$sf1}")
awk -v sf=$sf2 '{printf $1"\t"$2"\t"$3"\t" "%3.2f\n", $4*sf}' $bw1 > $pu2
sort -k1,1 -k2,2n $pu2 > $pu3
bedGraphToBigWig $pu3 GRCh38_RefseqGenomeSizesPlusHIV.txt $pu4
done





