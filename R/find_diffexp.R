#' Find the expression ratio for each experimental sample for the specified gene.
#'
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
  
  cl <- sapply(srratio, is.character)
  flt <- srratio[apply(srratio[cl], 1, function(g) g %in% genes), ]
  flt <- flt[, sapply(flt, is.numeric)]
  rownames(flt) <- sort(genes)
  flt <- t(flt)
  class(metadata) <- "data.frame"
  rownames(flt) <- metadata[, (apply(metadata, 2, function(col) all(col %in% colnames(srratio))))]
  list(result = cbind(metadata, flt),
       SRscore = srscore[which(unlist(Filter(is.character, srratio)) %in% genes), ])
}

