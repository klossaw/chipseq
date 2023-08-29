pkgs <- c("fs", "futile.logger", "configr", "stringr", "ggthemes", "jhtools", "glue", "tidyverse", "dplyr")  
for (pkg in pkgs){
  suppressPackageStartupMessages(library(pkg, character.only = T))
}
project <- "urology"
dataset <- "yingyufan"
species <- "human"
workdir <- glue("~/projects/{project}/analysis/{dataset}/{species}/chipseq")
workdir %>% checkdir() %>% setwd()
samples <- c("rwpe", "lncap", "22rv1", "c42", "c42b", "vcap", "pc3", "h660")
wkdir <- "/cluster/home/danyang_jh/projects/urology/analysis/yingyufan/human/chipseq"
# computeMatrix
for(samp in samples){
  ip_96_bw <- glue("{wkdir}/{samp}/peak_calling/{samp}_96.bw")
  input_96_bw <- glue("{wkdir}/{samp}/peak_calling/{samp}_96_input.bw")
  ip_g4_bw <- glue("{wkdir}/{samp}/peak_calling/{samp}_g4.bw")
  input_g4_bw <- glue("{wkdir}/{samp}/peak_calling/{samp}_g4_input.bw")
  ip_np <- glue("{wkdir}/{samp}/peak_calling/{samp}_peaks.narrowPeak")
  clx_mtx_dir <- glue("{wkdir}/{samp}/complexmatrix") 
  clx_mtx_dir %>% checkdir()
  out_fn1 <- glue("{clx_mtx_dir}/{samp}_all.gz")
  out_fn2 <- glue("{clx_mtx_dir}/{samp}_all_missingdata.gz")
  cmpmtx_temp_dir <- glue("{samp}/slrum_log")
  cmpmtx_temp_dir %>% checkdir()
  cmds1 <- glue("/cluster/apps/anaconda3/2020.02/envs/R-4.2.1/bin/computeMatrix reference-point -S {input_96_bw}  {ip_96_bw} {input_g4_bw} {ip_g4_bw} -R {ip_np} -o {out_fn1} -a 3000 -b 3000 --referencePoint center --binSize 10 -p 20 --skipZeros --missingDataAsZero")
  jhtools::sbatch(cmds = cmds1, dir = cmpmtx_temp_dir, p = "cpu", cpus_per_task = 20, jobname = "cmpmtx1", run = T, exclusive = F)
  cmds2 <- glue("/cluster/apps/anaconda3/2020.02/envs/R-4.2.1/bin/computeMatrix reference-point -S {input_96_bw}  {ip_96_bw} {input_g4_bw} {ip_g4_bw} -R {ip_np} -o {out_fn2} -a 3000 -b 3000 --referencePoint center --binSize 10 -p 20 --skipZeros")
  jhtools::sbatch(cmds = cmds2, dir = cmpmtx_temp_dir, p = "cpu", cpus_per_task = 20, jobname = "cmpmtx2", run = T, exclusive = F)
}
# plot the heatmap
for(samp in samples){
  clx_mtx_dir <- glue("{wkdir}/{samp}/complexmatrix")
  cpx_input1 <- glue("{clx_mtx_dir}/{samp}_all.gz")
  cpx_input2 <- glue("{clx_mtx_dir}/{samp}_all_missingdata.gz")
  out_heatmap1 <- glue("{clx_mtx_dir}/{samp}_all_heatmap.pdf")
  cmds1 <- glue("/cluster/apps/anaconda3/2020.02/envs/R-4.2.1/bin/plotHeatmap -m {cpx_input1} --colorMap 'bwr' -o {out_heatmap1}")
  jhtools::sbatch(cmds = cmds1, dir = cmpmtx_temp_dir, p = "cpu", cpus_per_task = 20, jobname = "cmpmtx1", run = T, exclusive = F)
  out_heatmap2 <- glue("{clx_mtx_dir}/{samp}_all_missingdata_heatmap.pdf")
  cmds2 <- glue("/cluster/apps/anaconda3/2020.02/envs/R-4.2.1/bin/plotHeatmap -m {cpx_input2} --colorMap 'bwr' -o {out_heatmap2}")
  jhtools::sbatch(cmds = cmds2, dir = cmpmtx_temp_dir, p = "cpu", cpus_per_task = 20, jobname = "cmpmtx2", run = T, exclusive = F)
  out_pf1 <- glue("{clx_mtx_dir}/{samp}_all_profile_line.pdf")
  cmds3 <- glue("/cluster/apps/anaconda3/2020.02/envs/R-4.2.1/bin/plotProfile -m {cpx_input1} -o {out_pf1} --perGroup")
  jhtools::sbatch(cmds = cmds3, dir = cmpmtx_temp_dir, p = "cpu", cpus_per_task = 20, jobname = "cmpmtx1", run = T, exclusive = F)
  out_pf2 <- glue("{clx_mtx_dir}/{samp}_all_missingdata_profile_line.pdf")
  cmds4 <- glue("/cluster/apps/anaconda3/2020.02/envs/R-4.2.1/bin/plotProfile -m {cpx_input2} -o {out_pf2} --perGroup")
  jhtools::sbatch(cmds = cmds4, dir = cmpmtx_temp_dir, p = "cpu", cpus_per_task = 20, jobname = "cmpmtx1", run = T, exclusive = F)
}
