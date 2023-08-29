# 05a: find differential peaks between 9.6 and g4
conda activate /cluster/home/flora_jh/.conda/envs/snakemake
cd ~/projects/urology/analysis/yingyufan/human/chipseq
samp=$1
mkdir -p 96_comp/tags
# confirm the program location
prgm_dir=/cluster/home/flora_jh/.conda/envs/snakemake/bin
# create tag directories, for parsing through the alignment file and spliting the tags into separate files based on chromosome
${prgm_dir}/makeTagDirectory 96_comp/tags/${samp} 96_comp/peak_calling/ip96_${samp}.sam -format sam
${prgm_dir}/makeTagDirectory g4_comp/tags/${samp} 96_comp/peak_calling/ip96_${samp}.sam -format sam

# getDifferentialPeaks for 9.6 
mkdir -p ./96_comp/diff_peaks
${prgm_dir}/getDifferentialPeaks 96_comp/peak_calling/ip96_${samp}.narrowPeak 96_comp/tags/${samp} 96_comp/tags/rwpe > ./96_comp/diff_peaks/${samp}_vs_rwpe_res.txt
# getDifferentialPeaks for g4
mkdir -p ./g4_comp/diff_peaks
${prgm_dir}/getDifferentialPeaks g4_comp/peak_calling/ipg4_${samp}.narrowPeak g4_comp/tags/${samp} g4_comp/tags/rwpe > ./g4_comp/diff_peaks/${samp}_vs_rwpe_res.txt

