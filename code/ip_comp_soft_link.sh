wkdir=/cluster/home/danyang_jh/projects/urology/analysis/yingyufan/human/chipseq
for i in 96 g4
do
mkdir -p ${i}_comp/peak_calling
# soft links of '.sam' files
ln -s ${wkdir}/${i}_comp/chilin/ip${i}_treat_rep1.sam ${wkdir}/${i}_comp/peak_calling/ip${i}_22rv1.sam
ln -s ${wkdir}/${i}_comp/chilin/ip${i}_treat_rep2.sam ${wkdir}/${i}_comp/peak_calling/ip${i}_c42.sam
ln -s ${wkdir}/${i}_comp/chilin/ip${i}_treat_rep3.sam ${wkdir}/${i}_comp/peak_calling/ip${i}_c42b.sam
ln -s ${wkdir}/${i}_comp/chilin/ip${i}_treat_rep4.sam ${wkdir}/${i}_comp/peak_calling/ip${i}_h660.sam
ln -s ${wkdir}/${i}_comp/chilin/ip${i}_treat_rep5.sam ${wkdir}/${i}_comp/peak_calling/ip${i}_lncap.sam
ln -s ${wkdir}/${i}_comp/chilin/ip${i}_treat_rep6.sam ${wkdir}/${i}_comp/peak_calling/ip${i}_pc3.sam
ln -s ${wkdir}/${i}_comp/chilin/ip${i}_treat_rep7.sam ${wkdir}/${i}_comp/peak_calling/ip${i}_vcap.sam
ln -s ${wkdir}/${i}_comp/chilin/ip${i}_control_rep1.sam ${wkdir}/${i}_comp/peak_calling/ip${i}_rwpe.sam
# soft links of '.bw' files
ln -s ${wkdir}/${i}_comp/chilin/ip${i}_treat_rep1_treat.bw ${wkdir}/${i}_comp/peak_calling/ip${i}_22rv1.bw
ln -s ${wkdir}/${i}_comp/chilin/ip${i}_treat_rep2_treat.bw ${wkdir}/${i}_comp/peak_calling/ip${i}_c42.bw
ln -s ${wkdir}/${i}_comp/chilin/ip${i}_treat_rep3_treat.bw ${wkdir}/${i}_comp/peak_calling/ip${i}_c42b.bw
ln -s ${wkdir}/${i}_comp/chilin/ip${i}_treat_rep4_treat.bw ${wkdir}/${i}_comp/peak_calling/ip${i}_h660.bw
ln -s ${wkdir}/${i}_comp/chilin/ip${i}_treat_rep5_treat.bw ${wkdir}/${i}_comp/peak_calling/ip${i}_lncap.bw
ln -s ${wkdir}/${i}_comp/chilin/ip${i}_treat_rep6_treat.bw ${wkdir}/${i}_comp/peak_calling/ip${i}_pc3.bw
ln -s ${wkdir}/${i}_comp/chilin/ip${i}_treat_rep7_treat.bw ${wkdir}/${i}_comp/peak_calling/ip${i}_vcap.bw

ln -s ${wkdir}/${i}_comp/chilin/ip${i}_treat_rep1_control.bw ${wkdir}/${i}_comp/peak_calling/ip${i}_22rv1_rwpe.bw
ln -s ${wkdir}/${i}_comp/chilin/ip${i}_treat_rep2_control.bw ${wkdir}/${i}_comp/peak_calling/ip${i}_c42_rwpe.bw
ln -s ${wkdir}/${i}_comp/chilin/ip${i}_treat_rep3_control.bw ${wkdir}/${i}_comp/peak_calling/ip${i}_c42b_rwpe.bw
ln -s ${wkdir}/${i}_comp/chilin/ip${i}_treat_rep4_control.bw ${wkdir}/${i}_comp/peak_calling/ip${i}_h660_rwpe.bw
ln -s ${wkdir}/${i}_comp/chilin/ip${i}_treat_rep5_control.bw ${wkdir}/${i}_comp/peak_calling/ip${i}_lncap_rwpe.bw
ln -s ${wkdir}/${i}_comp/chilin/ip${i}_treat_rep6_control.bw ${wkdir}/${i}_comp/peak_calling/ip${i}_pc3_rwpe.bw
ln -s ${wkdir}/${i}_comp/chilin/ip${i}_treat_rep7_control.bw ${wkdir}/${i}_comp/peak_calling/ip${i}_vcap_rwpe.bw
# soft links of '.narrowPeak' files
ln -s ${wkdir}/${i}_comp/chilin/ip${i}_treat_rep1_peaks.narrowPeak ${wkdir}/${i}_comp/peak_calling/ip${i}_22rv1.narrowPeak
ln -s ${wkdir}/${i}_comp/chilin/ip${i}_treat_rep2_peaks.narrowPeak ${wkdir}/${i}_comp/peak_calling/ip${i}_c42.narrowPeak
ln -s ${wkdir}/${i}_comp/chilin/ip${i}_treat_rep3_peaks.narrowPeak ${wkdir}/${i}_comp/peak_calling/ip${i}_c42b.narrowPeak
ln -s ${wkdir}/${i}_comp/chilin/ip${i}_treat_rep4_peaks.narrowPeak ${wkdir}/${i}_comp/peak_calling/ip${i}_h660.narrowPeak
ln -s ${wkdir}/${i}_comp/chilin/ip${i}_treat_rep5_peaks.narrowPeak ${wkdir}/${i}_comp/peak_calling/ip${i}_lncap.narrowPeak
ln -s ${wkdir}/${i}_comp/chilin/ip${i}_treat_rep6_peaks.narrowPeak ${wkdir}/${i}_comp/peak_calling/ip${i}_pc3.narrowPeak
ln -s ${wkdir}/${i}_comp/chilin/ip${i}_treat_rep7_peaks.narrowPeak ${wkdir}/${i}_comp/peak_calling/ip${i}_vcap.narrowPeak
ln -s ${wkdir}/${i}_comp/chilin/ip${i}_peaks.narrowPeak ${wkdir}/${i}_comp/peak_calling/ip${i}_peaks.narrowPeak
# soft links of '.bed' files
ln -s ${wkdir}/${i}_comp/chilin/ip${i}_treat_rep1_peaks.bed ${wkdir}/${i}_comp/peak_calling/ip${i}_22rv1.bed
ln -s ${wkdir}/${i}_comp/chilin/ip${i}_treat_rep2_peaks.bed ${wkdir}/${i}_comp/peak_calling/ip${i}_c42.bed
ln -s ${wkdir}/${i}_comp/chilin/ip${i}_treat_rep3_peaks.bed ${wkdir}/${i}_comp/peak_calling/ip${i}_c42b.bed
ln -s ${wkdir}/${i}_comp/chilin/ip${i}_treat_rep4_peaks.bed ${wkdir}/${i}_comp/peak_calling/ip${i}_h660.bed
ln -s ${wkdir}/${i}_comp/chilin/ip${i}_treat_rep5_peaks.bed ${wkdir}/${i}_comp/peak_calling/ip${i}_lncap.bed
ln -s ${wkdir}/${i}_comp/chilin/ip${i}_treat_rep6_peaks.bed ${wkdir}/${i}_comp/peak_calling/ip${i}_pc3.bed
ln -s ${wkdir}/${i}_comp/chilin/ip${i}_treat_rep7_peaks.bed ${wkdir}/${i}_comp/peak_calling/ip${i}_vcap.bed
ln -s ${wkdir}/${i}_comp/chilin/ip${i}_peaks.bed ${wkdir}/${i}_comp/peak_calling/ip${i}_peaks.bed

done

