#!/bin/bash
#SBATCH --nodes=1
#SBATCH --mem=4gb
#SBATCH --ntasks=4

cd $SLURM_SUBMIT_DIR
module load bedtools
SeacrFiles=( $(ls 474*stringent.bed) )
for SM in ${SeacrFiles[@]}; do
TotalCount=${SM/.bed/.TotalCount}
H3K4me1Count=${SM/.bed/.H3K4me1Count}
H3K4me3Count=${SM/.bed/.H3K4me3Count}
H3K36me3Count=${SM/.bed/.H3K36me3Count}
H3K27acCount=${SM/.bed/.H3K27acCount}
H3K27ac2Count=${SM/.bed/.H3K27ac2Count}
Filt=${SM/.bed/.filtbed}
FiltCount=${SM/.bed/FiltCount}
FiltH3K4me1Count=${SM/.bed/.FiltH3K4me1Count}
FiltH3K4me3Count=${SM/.bed/.FiltH3K4me3Count}
FiltH3K36me3Count=${SM/.bed/.FiltH3K36me3Count}
FiltH3K27acCount=${SM/.bed/.FiltH3K27acCount}
FiltH3K27ac2Count=${SM/.bed/.FiltH3K27ac2Count}
AllCounts=${SM/.bed/.AllMarkerCounts}
wc -l $SM > $TotalCount

bedtools intersect -wa -a $SM -b H3K4me3_ModShifted.bed | awk '!visited[$0]++' | wc -l > $H3K4me3Count
bedtools intersect -wa -a $SM -b H3K4me1MacsPeaksFilt_Mod_remapped_shifted.bed | awk '!visited[$0]++' | wc -l > $H3K4me1Count 
bedtools intersect -wa -a $SM -b H3k36me3RemappedModShifted.bed | awk '!visited[$0]++' | wc -l > $H3K36me3Count
bedtools intersect -wa -a $SM -b H3k27acRemappedModShifted.bed | awk '!visited[$0]++' | wc -l > $H3K27acCount
bedtools intersect -wa -a $SM -b GSM5028231_H3K27acMacsPeaks | awk '!visited[$0]++' | wc -l > $H3K27ac2Count
awk '$5>10 {print $0}' $SM > $Filt

wc -l $Filt > $FiltCount
bedtools intersect -wa -a $Filt -b H3K4me3_ModShifted.bed | awk '!visited[$0]++' | wc -l > $FiltH3K4me3Count
bedtools intersect -wa -a $Filt -b H3K4me1MacsPeaksFilt_Mod_remapped_shifted.bed | awk '!visited[$0]++' | wc -l > $FiltH3K4me1Count
bedtools intersect -wa -a $Filt -b H3k36me3RemappedModShifted.bed | awk '!visited[$0]++' | wc -l > $FiltH3K36me3Count
bedtools intersect -wa -a $Filt -b H3k27acRemappedModShifted.bed | awk '!visited[$0]++' | wc -l > $FiltH3K27acCount
bedtools intersect -wa -a $Filt -b GSM5028231_H3K27acMacsPeaks | awk '!visited[$0]++' | wc -l > $FiltH3K27ac2Count
cat $TotalCount $H3K4me3Count $H3K4me1Count $H3K36me3Count $H3K27acCount $H3K27ac2Count $FiltCount $FiltH3K4me3Count $FiltH3K4me1Count $FiltH3K36me3Count $FiltH3K27acCount $FiltH3K27ac2Count > $AllCounts
done
