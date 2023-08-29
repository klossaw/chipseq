pkgs <- c("fs", "futile.logger", "configr", "stringr", "ggthemes", "jhtools", "glue", "tidyverse", "dplyr")  
for (pkg in pkgs){
  suppressPackageStartupMessages(library(pkg, character.only = T))
}
project <- "urology"
dataset <- "yingyufan"
species <- "human"
workdir <- glue("~/projects/{project}/analysis/{dataset}/{species}/chipseq")
workdir %>% checkdir() %>% setwd()

samp <- c("rwpe", "lncap", "22rv1", "c42", "c42b", "vcap", "pc3", "h660")
# chipseq pipeline 
for(i in samp){
  config_file1 <- glue("{workdir}/{i}_config")
  cmds1 <- glue("chilin run -c {config_file1} --threads 20 --dont_remove --pe --skip 1,10,11,12,13 &> {i}/{i}_chilin.log")
  jhtools::sbatch(cmds = cmds1, dir = workdir, p = "cpu", cpus_per_task = 20, 
                  jobname = "yyf_chip", run = T, exclusive = F)

  
  # print(cmds)
}



