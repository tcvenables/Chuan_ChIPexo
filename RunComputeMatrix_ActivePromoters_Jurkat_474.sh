#!/bin/bash
#SBATCH --nodes=1
#SBATCH --mem=24gb
#SBATCH --ntasks=16

cd $SLURM_SUBMIT_DIR
module load python 
computeMatrix reference-point --referencePoint center -b 2000 -a 2000 -bs 100 -R Jurkat_ActivePromoters_Filt.bed -S 474-1_22Jan2022_filtchrSort.fx.dupr.NameSort.frag.cleanNORMsort.bw \
474-2_22Jan2022_filtchrSort.fx.dupr.NameSort.frag.cleanNORMsort.bw 474-3_22Jan2022_filtchrSort.fx.dupr.NameSort.frag.cleanNORMsort.bw \
474-4_22Jan2022_filtchrSort.fx.dupr.NameSort.frag.cleanNORMsort.bw 474-5_22Jan2022_filtchrSort.fx.dupr.NameSort.frag.cleanNORMsort.bw \
474-6_22Jan2022_filtchrSort.fx.dupr.NameSort.frag.cleanNORMsort.bw 474-7_22Jan2022_filtchrSort.fx.dupr.NameSort.frag.cleanNORMsort.bw \
474-8_22Jan2022_filtchrSort.fx.dupr.NameSort.frag.cleanNORMsort.bw 474-9_22Jan2022_filtchrSort.fx.dupr.NameSort.frag.cleanNORMsort.bw \
474-10_22Jan2022_filtchrSort.fx.dupr.NameSort.frag.cleanNORMsort.bw 474-11_22Jan2022_filtchrSort.fx.dupr.NameSort.frag.cleanNORMsort.bw \
474-12_22Jan2022_filtchrSort.fx.dupr.NameSort.frag.cleanNORMsort.bw --skipZeros -o 474_Jurkat_ActivePromoters_Filt.gz -p 6


plotHeatmap -m 474_Jurkat_ActivePromoters_Filt.gz -o 474_Jurkat_ActivePromoters_Filt.png --outFileSortedRegions 474_Jurkat_ActivePromoters_Filt_SortedRegions --outFileNameMatrix 474_Jurkat_ActivePromoters_Filt_NameMatrix

awk 'NR>1 && NR<5002 {print $0}' 474_Jurkat_ActivePromoters_Filt_SortedRegions > 474_Jurkat_ActivePromoters_Filt_SortedRegions_Head
awk 'NR>3 && NR<5004 {print $0}' 474_Jurkat_ActivePromoters_Filt_NameMatrix > 474_Jurkat_ActivePromoters_Filt_NameMatrix_Head
awk 'NR>3 {print $0}' 474_Jurkat_ActivePromoters_Filt_NameMatrix_NameMatrix > 474_Jurkat_ActivePromoters_Filt_NameMatrix_NoHeader
