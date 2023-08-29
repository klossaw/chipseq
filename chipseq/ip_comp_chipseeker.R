# peak annotation
pkgs <- c("fs", "futile.logger", "configr", "stringr", "ggpubr", "ggthemes", 
          "jhtools", "glue", "ggsci", "patchwork", "tidyverse", "dplyr", "clusterProfiler", 
          "GenomicFeatures", "TxDb.Hsapiens.UCSC.hg38.knownGene", "ChIPseeker")  
for (pkg in pkgs){
  suppressPackageStartupMessages(library(pkg, character.only = T))
}
project <- "urology"
dataset <- "yingyufan"
species <- "human"
workdir <- glue("~/projects/{project}/analysis/{dataset}/{species}/chipseq")
workdir %>% fs::dir_create() %>% setwd()

samples <- c("22rv1", "c42", "c42b", "h660", "lncap", "pc3", "vcap")
groups <- c("96", "g4")
kegg_anno_fn <- "/cluster/home/jhuang/bin/R/Rlibrary/4.2.1_conda/jhdata/extdata/kegg/hsa_annotion_modify.txt"
kegg_anno_info <- readr::read_tsv(kegg_anno_fn, col_names = c("ID", "Description"))
# get annotation information about each peak with TxDb
lapply(samples, \(samp){
  for(gp in groups) {
    glue("{gp}_comp/peaks_annotation/ip{gp}_{samp}_rwpe") %>% fs::dir_create()
    # read the peaks and plot the region coverage
    peak <- readPeakFile(glue("{gp}_comp/peak_calling/ip{gp}_{samp}.narrowPeak"))
    p <- covplot(peak, weightCol = "V5", chrs = paste0("chr", c(1:22, "X", "Y"))) + 
      theme(text = element_text(size = 6))
    ggsave(glue("{gp}_comp/peaks_annotation/ip{gp}_{samp}_rwpe/peak_region_coverage_each_chr.pdf"), p, width = 8, height = 12)
    # annotation
    peak_anno <- annotatePeak(peak, tssRegion = c(-3000, 3000),
                              TxDb = TxDb.Hsapiens.UCSC.hg38.knownGene, annoDb="org.Hs.eg.db")
    peak_anno_tbl <- peak_anno %>% as.data.frame() %>% tibble::tibble() %>% .[, -8]
    colnames(peak_anno_tbl)[6:11] <- c("name", "score", "signalValue", "pValue(-log10)", "qValue(-log10)", "point_source")
    readr::write_tsv(peak_anno_tbl, glue("{gp}_comp/peaks_annotation/ip{gp}_{samp}_rwpe/peaks_annotation_tbl.xls"))
    # plots
    pdf(glue("{gp}_comp/peaks_annotation/ip{gp}_{samp}_rwpe/peak_annot_pie.pdf"))
      plotAnnoPie(peak_anno) # calculate ratio of genomic annotation
    dev.off()
    tss_dist_p <- plotDistToTSS(peak_anno, title = "Distribution of transcription factor-binding loci relative to TSS") + 
      theme(text = element_text(size = 6))
    ggsave(glue("{gp}_comp/peaks_annotation/ip{gp}_{samp}_rwpe/tss_dist_bar.pdf"), tss_dist_p, width = 4, height = 2)
    # enrichment of all the annotated peaks
    entrezid_geneid <- dplyr::select(peak_anno_tbl, c("geneId", "SYMBOL")) %>% dplyr::distinct() %>% as.data.frame()
    
    peak_enrich_lst <- list()
    for(ctg in c("BP", "CC", "MF")){
      try({
        peak_enrich_lst[[ctg]] <- 
          enrichGO(gene = peak_anno_tbl$geneId, ont = ctg, OrgDb = "org.Hs.eg.db", 
                   pAdjustMethod = "BH", pvalueCutoff = 1, qvalueCutoff = 1, readable = TRUE)
        
      })
    }
    readr::write_rds(peak_enrich_lst, glue("{gp}_comp/peaks_annotation/ip{gp}_{samp}_rwpe/peak_annot_enrichment_GO.rds"))
    peak_enrich_lst[["kegg"]] <- clusterProfiler::enrichKEGG(gene = peak_anno_tbl$geneId, pvalueCutoff = 1, 
                                                             qvalueCutoff = 1, use_internal_data = TRUE)
    kegg_idx <- lapply(1:nrow(peak_enrich_lst[["kegg"]]), \(i){
      which(kegg_anno_info$ID %in% peak_enrich_lst[["kegg"]]@result$ID[i])
    }) %>% unlist()
    exist_idx <- peak_enrich_lst[["kegg"]]@result$ID %in% kegg_anno_info$ID # there's a mismatch
    peak_enrich_lst[["kegg"]]@result$Description[exist_idx] <- kegg_anno_info[[2]][kegg_idx]
    peak_enrich_lst[["kegg"]]@result$geneID <- 
      lapply(peak_enrich_lst[["kegg"]]@result$geneID, \(chr){
        entrezid <- chr %>% strsplit(split = "/") %>% unlist()
        idx <- which(entrezid_geneid$geneId %in% entrezid)
        entrezid_geneid[idx,] %>% pull(SYMBOL) %>% stringr::str_c(collapse = "/")
      }) %>% unlist()
    write_rds(peak_enrich_lst[["kegg"]], glue("{gp}_comp/peaks_annotation/ip{gp}_{samp}_rwpe/peak_annot_enrichment_kegg.rds"))
    # dotplot of enrichment
    parallel::mclapply(c("BP", "CC", "MF", "kegg"), \(ctg){
      try({
        p <- clusterProfiler::dotplot(peak_enrich_lst[[ctg]], font.size = 6) + theme(text = element_text(size = 6))
        if(ctg != "kegg") {
          ggsave(glue("{gp}_comp/peaks_annotation/ip{gp}_{samp}_rwpe/peak_anno_enrichment_GO_{ctg}.pdf"), p, width = 4, height = 4)
        } else {
          ggsave(glue("{gp}_comp/peaks_annotation/ip{gp}_{samp}_rwpe/peak_anno_enrichment_{ctg}.pdf"), p, width = 4, height = 4)
        }
        readr::write_tsv(peak_enrich_lst[[ctg]]@result, glue("{gp}_comp/peaks_annotation/ip{gp}_{samp}_rwpe/enrich_res_{ctg}.xls"))
      })
    }, mc.cores = 4)
    
  }
})
