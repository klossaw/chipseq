pkgs <- c("fs", "futile.logger", "configr", "stringr", "ggpubr", "ggthemes", 
      "jhtools", "glue", "ggsci", "patchwork", "tidyverse", "dplyr", "ggvenn")  
for (pkg in pkgs){
  suppressPackageStartupMessages(library(pkg, character.only = T))
}
project <- "urology"
dataset <- "yingyufan"
species <- "human"
workdir <- glue("~/projects/{project}/analysis/{dataset}/{species}/chipseq")
workdir %>% fs::dir_create() %>% setwd()

samples <- c("22rv1", "c42", "c42b", "h660", "lncap", "pc3", "rwpe", "vcap")
pbmcapply::pbmclapply(samples, \(samp){
  intsect_fn <- glue("{samp}/peaks_intersect/bedtools_intersect_96_g4.bed")
  peaks_intsect <- readr::read_table(intsect_fn, col_names = F)
  colnam_common <- c("chrom", "start", "end", "peak_names", "score")
  colnames(peaks_intsect) <- c(paste0(rep(colnam_common, 2), rep(c("_g4", "_96"), each = 5)), "common_length")
  peaks_intsect$peak_names_g4 <- paste0("g4_", peaks_intsect$peak_names_g4)
  peaks_intsect$peak_names_96 <- paste0("96_", peaks_intsect$peak_names_96)
  peaks_intsect$pair <- paste0(peaks_intsect$peak_names_g4, "/", peaks_intsect$peak_names_96)
  
  bed_fn1 <- glue("{samp}/{samp}_chilin/{samp}_treat_rep1_peaks.bed")
  peaks_96 <- readr::read_table(bed_fn1, col_names = colnam_common) %>% 
    mutate(ip = "96", common_length = 0, pair = "none")
  peaks_96$peak_names <- paste0("96_", peaks_96$peak_names)
  idx1 <- peaks_96$peak_names %in% peaks_intsect$peak_names_96
  peaks_96$common_length[idx1] <- peaks_intsect$common_length
  peaks_96$pair[idx1] <- peaks_intsect$pair
  bed_fn2 <- glue("{samp}/{samp}_chilin/{samp}_treat_rep2_peaks.bed")
  peaks_g4 <- readr::read_table(bed_fn2, col_names = colnam_common) %>% 
    mutate(ip = "g4", common_length = 0, pair = "none")
  peaks_g4$peak_names <- paste0("g4_", peaks_g4$peak_names)
  idx2 <- peaks_g4$peak_names %in% peaks_intsect$peak_names_g4
  peaks_g4$common_length[idx2] <- peaks_intsect$common_length
  peaks_g4$pair[idx2] <- peaks_intsect$pair
  # bind by rows
  peaks_intsect_res <- rbind(peaks_g4, peaks_96) %>% 
    mutate(intersect = case_when(pair != "none" ~ T, TRUE ~ F))
  write_tsv(peaks_intsect_res, glue("{samp}/peaks_intersect/peaks_intsect_res.tsv"))
  
  intsect_res <- peaks_intsect_res %>% dplyr::select(c("ip", "peak_names", "pair", "intersect"))
  idx3 <- intsect_res$intersect
  intsect_res$peak_names[idx3] <- intsect_res$pair[idx3]
  p <- list(peaks_96 = intsect_res %>% dplyr::filter(ip == "96") %>% pull(peak_names), 
            peaks_g4 = intsect_res %>% dplyr::filter(ip == "g4") %>% pull(peak_names)) %>% 
    ggvenn()
  ggsave(glue("{samp}/peaks_intersect/peaks_intersect.pdf"), p, width = 4, height = 4)
})
