pkgs <- c("fs", "futile.logger", "configr", "stringr", "ggpubr", "ggthemes", 
      "jhtools", "glue", "ggsci", "patchwork", "tidyverse", "dplyr")  
for (pkg in pkgs){
  suppressPackageStartupMessages(library(pkg, character.only = T))
}
project <- "urology"
dataset <- "yingyufan"
species <- "human"
workdir <- glue("~/projects/{project}/analysis/{dataset}/{species}/chipseq")
workdir %>% fs::dir_create() %>% setwd()

samples <- c("rwpe", "lncap", "22rv1", "c42", "c42b", "vcap", "pc3", "h660")
wkdir <- "/cluster/home/danyang_jh/projects/urology/analysis/yingyufan/human/chipseq"

# for(samp in samples){
#   ip_96_peaks_fn <- glue("{wkdir}/{samp}/{samp}_chilin/{samp}_treat_rep1_peaks.xls")
#   ip_96_peaks <- readr::read_tsv(ip_96_peaks_fn, comment = "#") %>% 
#     mutate(peak_loc = paste0(chr, "_", start, "_", end))
#   ip_g4_peaks_fn <- glue("{wkdir}/{samp}/{samp}_chilin/{samp}_treat_rep2_peaks.xls")
#   ip_g4_peaks <- read_tsv(ip_g4_peaks_fn, comment = "#") %>% 
#     mutate(peak_loc = paste0(chr, "_", start, "_", end))
#   
# }
# NO COMMON PEAKS
# perhaps it needs homer to do that, via `FindDifferentialPeaks`

