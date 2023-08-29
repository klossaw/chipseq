pkgs <- c("fs", "futile.logger", "configr", "stringr", "ggthemes", "jhtools", "glue", "tidyverse", "dplyr")  
for (pkg in pkgs){
  suppressPackageStartupMessages(library(pkg, character.only = T))
}
project <- "urology"
dataset <- "yingyufan"
species <- "human"
workdir <- glue("~/projects/{project}/analysis/{dataset}/{species}/chipseq")
workdir %>% checkdir() %>% setwd()

samp <- c("96", "g4")
# chipseq pipeline 
for(i in samp){
  config_file1 <- glue("{workdir}/ip_{i}.config")
  cmds1 <- glue("chilin run -c {config_file1} --threads 20 --dont_remove --pe --skip 1,10,11,12,13 &> {i}_comp/{i}_chilin.log")
  jhtools::sbatch(cmds = cmds1, dir = workdir, p = "cpu", cpus_per_task = 20, 
                  jobname = "yyf_chip", run = T, exclusive = F)
  # print(cmds)
}
