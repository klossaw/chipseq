wkdir=/cluster/home/danyang_jh/projects/urology/analysis/yingyufan/human/chipseq
mkdir -p ${wkdir}/log_files

for samp in 22rv1 c42 c42b h660 lncap pc3 rwpe vcap
do
sh ~/projects/urology/code/yingyufan/chipseq/06a_motif_calling.sh ${samp} &> ${wkdir}/log_files/${samp}_06_motif.log
done

