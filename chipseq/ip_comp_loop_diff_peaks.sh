for i in 22rv1 c42 c42b h660 lncap pc3 rwpe vcap
do
	sh ~/projects/urology/code/yingyufan/human/chipseq/ip_comp_diff_peaks.sh ${i} &> log_files/ip_comp_${i}_diff_peaks.log
done
