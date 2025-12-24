#' Find the expression ratio for each experimental sample for the specified gene.
#'
#' This function retrieves SRratio (Stress Response ratio) values for one or 
#' more specified genes across all experimental samples and combines them with
#' the corresponding sample metadata. In addition, the corresponding 
#' SRscore (Stress Response score) values for the specified genes are returned.
#' The output is intended for downstream inspection and visualization of 
#' gene-level expression patterns across experimental conditions.
#'
#' @param genes character vector that can consist of gene IDs
#' @param srratio A dataframe of srratio
#' @param srscore A dataframe of srratio
#' @param metadata A dataframe of metadata
#'
#' @return
#' Data frame of metadata with SRratio corresponding to the specified gene ID in the back row
#'
#' @examples
#' vr1 <- "control_sample"
#' vr2 <- "treated_sample"
#' grp <- "Series"
#'
#' ebg <- expand_by_group(MetadataABA,
#'                        vr1,
#'                        vr2,
#'                        grp)
#'
#' SRratio <- calcSRratio(TranscriptomeABA,
#'                              vr1,
#'                              vr2,
#'                              ebg,
#'                              is.log = 1)
#'
#' SRscore <- calcSRscore(SRratio)
#'
#' set.seed(1)
#' find_diffexp(sample(SRratio$ensembl_gene_id, 1), SRratio, SRscore, MetadataABA)
#'
#' @export
find_diffexp <- function(genes, srratio, srscore, metadata) {
  
  cl_chr <- sapply(srratio, is.character)
  subset_srratio <- srratio[apply(srratio[cl_chr], 1, function(g) g %in% genes), ]
  cl_nm <- sapply(subset_srratio, is.numeric)
  subset_srratio_nm <- subset_srratio[, cl_nm]
  rownames(subset_srratio_nm) <- sort(genes)
  subset_srratio_nm <- t(subset_srratio_nm)
  class(metadata) <- "data.frame"
  
  if(!all(c("treated_sample") %in% colnames(metadata))) {
    stop("metadata must contain columns 'treated_sample'")
  }
  
  list(result = cbind(subset_srratio_nm, metadata[match(rownames(subset_srratio_nm), metadata$treated_sample), ]),
       SRscore = srscore[which(unlist(srratio[cl_chr]) %in% genes), ])
}