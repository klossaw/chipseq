
cd ~/projects/urology/analysis/yingyufan/human/chipseq
samp=$1
mkdir -p ${samp}/peaks_intersect
# find the intersection of 9.6 and g4
bedtools intersect \
-b ${samp}/${samp}_chilin/${samp}_treat_rep1_peaks.bed \
-a ${samp}/${samp}_chilin/${samp}_treat_rep2_peaks.bed \
-sorted -wo > ${samp}/peaks_intersect/bedtools_intersect_96_g4.bed

