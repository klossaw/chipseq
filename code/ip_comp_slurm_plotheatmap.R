pkgs <- c("fs", "futile.logger", "configr", "stringr", "ggthemes", "jhtools", "glue", "tidyverse", "dplyr")  
for (pkg in pkgs){
  suppressPackageStartupMessages(library(pkg, character.only = T))
}
project <- "urology"
dataset <- "yingyufan"
species <- "human"
workdir <- glue("~/projects/{project}/analysis/{dataset}/{species}/chipseq")
workdir %>% checkdir() %>% setwd()
samples <- c("lncap", "22rv1", "c42", "c42b", "vcap", "pc3", "h660")
wkdir <- "/cluster/home/danyang_jh/projects/urology/analysis/yingyufan/human/chipseq"
groups <- c("96", "g4")
samples <- c("rwpe", "lncap", "22rv1", "c42", "c42b", "vcap", "pc3", "h660")
# computeMatrix
for(gp in groups){
  for(samp in samples){
    ip_96_bw <- glue("{wkdir}/{gp}_comp/peak_calling/ip{gp}_{samp}.bw")
    input_96_bw <- glue("{wkdir}/{gp}_comp/peak_calling/ip{gp}_{samp}_rwpe.bw")
    # ip_g4_bw <- glue("{wkdir}/{gp}_comp/peak_calling/{samp}_g4.bw")
    # input_g4_bw <- glue("{wkdir}/{gp}_comp/peak_calling/{samp}_g4_input.bw")
    ip_np <- glue("{wkdir}/{gp}_comp/peak_calling/ip{gp}_{samp}.narrowPeak")
    clx_mtx_dir <- glue("{wkdir}/{gp}_comp/computematrix") 
    clx_mtx_dir %>% checkdir()
    out_fn1 <- glue("{clx_mtx_dir}/{samp}_rwpe.gz")
    out_fn2 <- glue("{clx_mtx_dir}/{samp}_rwpe_missingdata.gz")
    out_heatmap1 <- glue("{clx_mtx_dir}/ip{gp}_{samp}_heatmap.pdf")
    out_heatmap2 <- glue("{clx_mtx_dir}/ip{gp}_{samp}_missingdata_heatmap.pdf")
    cmpmtx_temp_dir <- glue("{gp}_comp/slrum_log")
    cmpmtx_temp_dir %>% checkdir()
    cmds1 <- glue("/cluster/apps/anaconda3/2020.02/envs/R-4.2.1/bin/plotHeatmap -m {out_fn1} --colorMap 'bwr' -o {out_heatmap1}")
    jhtools::sbatch(cmds = cmds1, dir = cmpmtx_temp_dir, p = "cpu", cpus_per_task = 20, jobname = "plotheatmap1_1", run = T, exclusive = F)
    out_heatmap2 <- glue("{clx_mtx_dir}/ip{gp}_{samp}_missingdata_heatmap.pdf")
    cmds2 <- glue("/cluster/apps/anaconda3/2020.02/envs/R-4.2.1/bin/plotHeatmap -m {out_fn2} --colorMap 'bwr' -o {out_heatmap2}")
    jhtools::sbatch(cmds = cmds2, dir = cmpmtx_temp_dir, p = "cpu", cpus_per_task = 20, jobname = "plotheatmap1_2", run = T, exclusive = F)
    out_pf1 <- glue("{clx_mtx_dir}/ip{gp}_{samp}_profile_line.pdf")
    cmds3 <- glue("/cluster/apps/anaconda3/2020.02/envs/R-4.2.1/bin/plotProfile -m {out_fn1} -o {out_pf1} --perGroup")
    jhtools::sbatch(cmds = cmds3, dir = cmpmtx_temp_dir, p = "cpu", cpus_per_task = 20, jobname = "plotheatmap2_1", run = T, exclusive = F)
    out_pf2 <- glue("{clx_mtx_dir}/ip{gp}_{samp}_missingdata_profile_line.pdf")
    cmds4 <- glue("/cluster/apps/anaconda3/2020.02/envs/R-4.2.1/bin/plotProfile -m {out_fn2} -o {out_pf2} --perGroup")
    jhtools::sbatch(cmds = cmds4, dir = cmpmtx_temp_dir, p = "cpu", cpus_per_task = 20, jobname = "plotheatmap2_2", run = T, exclusive = F)
  }
}
