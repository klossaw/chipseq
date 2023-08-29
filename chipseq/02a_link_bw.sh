wkdir=/cluster/home/danyang_jh/projects/urology/analysis/yingyufan/human/chipseq
for samp in 22rv1 c42 c42b h660 lncap pc3 rwpe vcap
do
mkdir -p ${wkdir}/${samp}/peak_calling
ln -s -T ${wkdir}/${samp}/${samp}_chilin/${samp}_treat_rep1_treat.bw ${wkdir}/${samp}/peak_calling/${samp}_96.bw
ln -s -T ${wkdir}/${samp}/${samp}_chilin/${samp}_treat_rep2_treat.bw ${wkdir}/${samp}/peak_calling/${samp}_g4.bw
ln -s -T ${wkdir}/${samp}/${samp}_chilin/${samp}_control.bw ${wkdir}/${samp}/peak_calling/${samp}_input.bw
ln -s -T ${wkdir}/${samp}/${samp}_chilin/${samp}_treat_rep1_peaks.narrowPeak ${wkdir}/${samp}/peak_calling/${samp}_96.narrowPeak
ln -s -T ${wkdir}/${samp}/${samp}_chilin/${samp}_treat_rep2_peaks.narrowPeak ${wkdir}/${samp}/peak_calling/${samp}_g4.narrowPeak
ln -s -T ${wkdir}/${samp}/${samp}_chilin/${samp}_peaks.narrowPeak ${wkdir}/${samp}/peak_calling/${samp}_peaks.narrowPeak
ln -s -T ${wkdir}/${samp}/${samp}_chilin/${samp}_treat_rep1_control.bw ${wkdir}/${samp}/peak_calling/${samp}_96_input.bw
ln -s -T ${wkdir}/${samp}/${samp}_chilin/${samp}_treat_rep2_control.bw ${wkdir}/${samp}/peak_calling/${samp}_g4_input.bw
done

