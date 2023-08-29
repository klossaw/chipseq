# 05a: find differential peaks between 9.6 and g4
conda activate /cluster/home/flora_jh/.conda/envs/snakemake
cd ~/projects/urology/analysis/yingyufan/human/chipseq
samp=$1
mkdir -p ${samp}/tags
# confirm the program location
prgm_dir=/cluster/home/flora_jh/.conda/envs/snakemake/bin
# create tag directories, for parsing through the alignment file and spliting the tags into separate files based on chromosome
${prgm_dir}/makeTagDirectory ${samp}/tags/ip_96 ${samp}/${samp}_chilin/${samp}_treat_rep1.sam -format sam
${prgm_dir}/makeTagDirectory ${samp}/tags/ip_g4 ${samp}/${samp}_chilin/${samp}_treat_rep2.sam -format sam
${prgm_dir}/makeTagDirectory ${samp}/tags/input ${samp}/${samp}_chilin/${samp}_control_rep1.sam -format sam

# getDifferentialPeaks for 9.6 vs g4
mkdir -p ./${samp}/diff_peaks
${prgm_dir}/getDifferentialPeaks ${samp}/${samp}_chilin/${samp}_peaks.narrowPeak ${samp}/tags/ip_96 ${samp}/tags/ip_g4 > ./${samp}/diff_peaks/${samp}_96_vs_g4_res.txt
# getDifferentialPeaks for 9.6 vs input and g4 vs input
${prgm_dir}/getDifferentialPeaks ${samp}/${samp}_chilin/${samp}_peaks.narrowPeak ${samp}/tags/ip_96 ${samp}/tags/input > ./${samp}/diff_peaks/${samp}_96_vs_in_res.txt
${prgm_dir}/getDifferentialPeaks ${samp}/${samp}_chilin/${samp}_peaks.narrowPeak ${samp}/tags/ip_g4 ${samp}/tags/input > ./${samp}/diff_peaks/${samp}_g4_vs_in_res.txt
