pkgs <- c("fs", "futile.logger", "configr", "stringr", "ggthemes", "jhtools", "glue", "tidyverse", "dplyr")  
for (pkg in pkgs){
  suppressPackageStartupMessages(library(pkg, character.only = T))
}
project <- "urology"
dataset <- "yingyufan"
species <- "human"
workdir <- glue("~/projects/{project}/analysis/{dataset}/{species}/chipseq")
workdir %>% checkdir() %>% setwd()
"log_files" %>% fs::dir_create()
samp <- c("rwpe", "lncap", "22rv1", "c42", "c42b", "vcap", "pc3", "h660")
# chipseq pipeline 
for(i in samp){
  sh_fn <- "/cluster/home/danyang_jh/projects/urology/code/yingyufan/chipseq/06a_motif_calling.sh"
  cmds1 <- glue("sh {sh_fn} {samp} &> {workdir}/log_files/{samp}_06_motif.log")
  jhtools::sbatch(cmds = cmds1, dir = workdir, p = "cpu", cpus_per_task = 5, 
                  jobname = "motif", run = T, exclusive = F)
  # print(cmds)
}
