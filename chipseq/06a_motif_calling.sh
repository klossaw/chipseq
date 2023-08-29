# 06a: motif calling, via homer
cd ~/projects/urology/analysis/yingyufan/human/chipseq
# confirm the program location
source /cluster/apps/anaconda3/2020.02/etc/profile.d/conda.sh
conda activate /cluster/home/flora_jh/.conda/envs/snakemake
prgm_dir=/cluster/home/flora_jh/.conda/envs/snakemake/bin


for samp in 22rv1 c42 c42b h660 lncap pc3 rwpe vcap
do
mkdir -p ${samp}/motif/homer_tmp
# call the motifs
awk '{print $4"\t"$1"\t"$2"\t"$3"\t+"}' ./${samp}/${samp}_chilin/${samp}_peaks.bed > ${samp}/motif/homer_tmp/${samp}_peaks_homer.tmp
time ${prgm_dir}/findMotifsGenome.pl ${samp}/motif/homer_tmp/${samp}_peaks_homer.tmp hg38 ${samp}/motif/${samp}_peaks_motif -len 8,10,12 &> ${samp}/motif/${samp}_peaks_homer_motif.log &

awk '{print $4"\t"$1"\t"$2"\t"$3"\t+"}' ./${samp}/${samp}_chilin/${samp}_treat_rep1_peaks.bed > ${samp}/motif/homer_tmp/${samp}_96_homer.tmp
time ${prgm_dir}/findMotifsGenome.pl ${samp}/motif/homer_tmp/${samp}_96_homer.tmp hg38 ${samp}/motif/${samp}_96_motif -len 8,10,12 &> ${samp}/motif/${samp}_96_homer_motif.log &

awk '{print $4"\t"$1"\t"$2"\t"$3"\t+"}' ./${samp}/${samp}_chilin/${samp}_treat_rep2_peaks.bed > ${samp}/motif/homer_tmp/${samp}_g4_homer.tmp
time ${prgm_dir}/findMotifsGenome.pl ${samp}/motif/homer_tmp/${samp}_g4_homer.tmp hg38 ${samp}/motif/${samp}_g4_motif -len 8,10,12 &> ${samp}/motif/${samp}_g4_homer_motif.log &
done
