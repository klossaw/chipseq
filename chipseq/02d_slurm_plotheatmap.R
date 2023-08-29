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
# plot the heatmap
for(samp in samples){
  clx_mtx_dir <- glue("{wkdir}/{samp}/complexmatrix")
  cpx_input1 <- glue("{clx_mtx_dir}/{samp}_96.gz")
  cpx_input2 <- glue("{clx_mtx_dir}/{samp}_96_missingdata.gz")
  out_heatmap1 <- glue("{clx_mtx_dir}/{samp}_96_heatmap.pdf")
  cmpmtx_temp_dir <- glue("{samp}/slrum_log")
  cmpmtx_temp_dir %>% checkdir()
  cmds1 <- glue("/cluster/apps/anaconda3/2020.02/envs/R-4.2.1/bin/plotHeatmap -m {cpx_input1} --colorMap 'bwr' -o {out_heatmap1}")
  jhtools::sbatch(cmds = cmds1, dir = cmpmtx_temp_dir, p = "cpu", cpus_per_task = 20, jobname = "plotheatmap1_1", run = T, exclusive = F)
  out_heatmap2 <- glue("{clx_mtx_dir}/{samp}_96_missingdata_heatmap.pdf")
  cmds2 <- glue("/cluster/apps/anaconda3/2020.02/envs/R-4.2.1/bin/plotHeatmap -m {cpx_input2} --colorMap 'bwr' -o {out_heatmap2}")
  jhtools::sbatch(cmds = cmds2, dir = cmpmtx_temp_dir, p = "cpu", cpus_per_task = 20, jobname = "plotheatmap1_2", run = T, exclusive = F)
  out_pf1 <- glue("{clx_mtx_dir}/{samp}_96_profile_line.pdf")
  cmds3 <- glue("/cluster/apps/anaconda3/2020.02/envs/R-4.2.1/bin/plotProfile -m {cpx_input1} -o {out_pf1} --perGroup")
  jhtools::sbatch(cmds = cmds3, dir = cmpmtx_temp_dir, p = "cpu", cpus_per_task = 20, jobname = "plotheatmap2_1", run = T, exclusive = F)
  out_pf2 <- glue("{clx_mtx_dir}/{samp}_96_missingdata_profile_line.pdf")
  cmds4 <- glue("/cluster/apps/anaconda3/2020.02/envs/R-4.2.1/bin/plotProfile -m {cpx_input2} -o {out_pf2} --perGroup")
  jhtools::sbatch(cmds = cmds4, dir = cmpmtx_temp_dir, p = "cpu", cpus_per_task = 20, jobname = "plotheatmap2_2", run = T, exclusive = F)
}
# plot the heatmap 2
for(samp in samples){
  clx_mtx_dir <- glue("{wkdir}/{samp}/complexmatrix")
  cpx_input1 <- glue("{clx_mtx_dir}/{samp}_g4.gz")
  cpx_input2 <- glue("{clx_mtx_dir}/{samp}_g4_missingdata.gz")
  out_heatmap1 <- glue("{clx_mtx_dir}/{samp}_g4_heatmap.pdf")
  cmpmtx_temp_dir <- glue("{samp}/slrum_log")
  cmpmtx_temp_dir %>% checkdir()
  cmds1 <- glue("/cluster/apps/anaconda3/2020.02/envs/R-4.2.1/bin/plotHeatmap -m {cpx_input1} --colorMap 'bwr' -o {out_heatmap1}")
  jhtools::sbatch(cmds = cmds1, dir = cmpmtx_temp_dir, p = "cpu", cpus_per_task = 20, jobname = "plotheatmap3_1", run = T, exclusive = F)
  out_heatmap2 <- glue("{clx_mtx_dir}/{samp}_g4_missingdata_heatmap.pdf")
  cmds2 <- glue("/cluster/apps/anaconda3/2020.02/envs/R-4.2.1/bin/plotHeatmap -m {cpx_input2} --colorMap 'bwr' -o {out_heatmap2}")
  jhtools::sbatch(cmds = cmds2, dir = cmpmtx_temp_dir, p = "cpu", cpus_per_task = 20, jobname = "plotheatmap3_2", run = T, exclusive = F)
  out_pf1 <- glue("{clx_mtx_dir}/{samp}_g4_profile_line.pdf")
  cmds3 <- glue("/cluster/apps/anaconda3/2020.02/envs/R-4.2.1/bin/plotProfile -m {cpx_input1} -o {out_pf1} --perGroup")
  jhtools::sbatch(cmds = cmds3, dir = cmpmtx_temp_dir, p = "cpu", cpus_per_task = 20, jobname = "plotheatmap4_1", run = T, exclusive = F)
  out_pf2 <- glue("{clx_mtx_dir}/{samp}_g4_missingdata_profile_line.pdf")
  cmds4 <- glue("/cluster/apps/anaconda3/2020.02/envs/R-4.2.1/bin/plotProfile -m {cpx_input2} -o {out_pf2} --perGroup")
  jhtools::sbatch(cmds = cmds4, dir = cmpmtx_temp_dir, p = "cpu", cpus_per_task = 20, jobname = "plotheatmap4_2", run = T, exclusive = F)
}
