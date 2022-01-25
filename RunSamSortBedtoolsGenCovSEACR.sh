#!/bin/bash
#SBATCH --nodes=1
#SBATCH --mem=24gb
#SBATCH --ntasks=16

cd $SLURM_SUBMIT_DIR
module load samtools
module load bedtools
module load R


SamFiles=( $(ls 561*22Jan2022.sam) )
for s1 in ${SamFiles[@]}; do
sam2name=${s1/.sam/_filt.sam}
sam3name=${s1/.sam/_filtPPcheck.sam}
bam2name=${sam2name/.sam/.bam}
bam3name=${bam2name/.bam/fx.bam}
bam4name=${bam3name/fx.bam/chrSort.fx.bam}
bam5name=${bam4name/chrSort.fx.bam/chrSort.fx.dupr.bam}
bam6name=${bam5name/dupr.bam/dupr.NameSort.bam}
bed2name=${bam6name/.bam/.bed}
bed3name=${bed2name/bed/clean.bed}
bed4name=${bed3name/clean.bed/frag.clean.bed}
BdgName=${bed4name/bed/bdg}
SeacrPeaks=${BdgName/bdg/seacr_peaks}

samtools view -f 2 -q 20 -h -o $sam2name $s1 
samtools view -q 20 -h -o $sam3name $s1
samtools sort -n -o $bam2name -O bam $sam2name
samtools fixmate -m $bam2name $bam3name
samtools sort -o $bam4name -O bam $bam3name
samtools markdup -r -s $bam4name $bam5name
samtools sort -n -o $bam6name -O bam $bam5name
bedtools bamtobed -bedpe -i $bam6name > $bed2name
awk '$1==$4 && $6-$2 < 1000 {print $0}' $bed2name > $bed3name
cut -f 1,2,6 $bed3name | sort -k1,1 -k2,2n -k3,3n > $bed4name
bedtools genomecov -bg -i $bed4name -g GRCh38_JurkatHivIntRefseqGenomeSizes.txt > $BdgName 
bash SEACR/SEACR_1.3.sh $BdgName 0.01 non stringent $SeacrPeaks
bash SEACR/SEACR_1.3.sh $BdgName 0.01 non relaxed $SeacrPeaks
rm $sam2name $bam2name $bam3name $bam4name $bed2name
done

