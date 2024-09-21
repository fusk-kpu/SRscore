#' Obtain the conditions under which differential expression of the specified gene was observed.
#'
#'
#' @param genes description
#' @param srratio description
#' @param metadata description
#'
#' @return
#' @examples
#' ebg <- expand_by_group(MetadataABA, control_sample, treated_sample, Series)
#'
#' SRratio <- calculate_SRratio(TranscriptomeABA, "control_sample",
#'                              "treated_sample", ebg, is.logarithmic = 1)
#' set.seed(1)
#' get_diffexp(sample(SRratio$ensembl_gene_id, 1), SRratio, MetadataABA)
#'
#'
#' @export
get_diffexp <- function(genes, srratio, metadata) {
  flt <- Filter(is.numeric,
                srratio[apply(Filter(is.character, srratio), 1, function(g) g %in% genes), ])
  rownames(flt) <- sort(genes)
  cbind(metadata, t(flt))
}
