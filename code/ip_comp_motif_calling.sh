# 06a: motif calling, via homer
cd ~/projects/urology/analysis/yingyufan/human/chipseq
# confirm the program location
source /cluster/apps/anaconda3/2020.02/etc/profile.d/conda.sh
conda activate /cluster/home/flora_jh/.conda/envs/snakemake
prgm_dir=/cluster/home/flora_jh/.conda/envs/snakemake/bin
mkdir -p 96_comp/homer_tmp
mkdir -p g4_comp/homer_tmp

for samp in 22rv1 c42 c42b h660 lncap pc3 vcap
do
mkdir -p ${samp}/motif/homer_tmp
# call the motifs
awk '{print $4"\t"$1"\t"$2"\t"$3"\t+"}' ./96_comp/peak_calling/ip96_${samp}.bed > ./96_comp/homer_tmp/ip96_${samp}_peaks_homer.tmp
${prgm_dir}/findMotifsGenome.pl ./96_comp/homer_tmp/ip96_${samp}_peaks_homer.tmp hg38 ./96_comp/motif/ip96_${samp}_peaks_motif -len 8,10,12 &> ./96_comp/motif/ip96_${samp}_peaks_homer_motif.log &

awk '{print $4"\t"$1"\t"$2"\t"$3"\t+"}' ./g4_comp/peak_calling/ipg4_${samp}.bed > ./g4_comp/homer_tmp/ipg4_${samp}_peaks_homer.tmp
${prgm_dir}/findMotifsGenome.pl ./g4_comp/homer_tmp/ipg4_${samp}_peaks_homer.tmp hg38 ./g4_comp/motif/ipg4_${samp}_peaks_motif -len 8,10,12 &> ./g4_comp/motif/ipg4_${samp}_peaks_homer_motif.log &

done
