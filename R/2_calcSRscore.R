#' Create a Data Frame of SRscore
#'
#' SRscore is score value of genes based expression profiles across different research projects.
#' SRratio is required to calculate SRscore.
#'
#' @param srratio A data frame of SRratio.
#' @param threshold A vector of length 2 (x, y) indicating threshold values. `c(-1, 1)` is default.
#'
#' @return A data frame containing results.
#'
#' @examples
#' grp <- "Series"
#' var1 <- "control_sample"
#' var2 <- "treated_sample"
#'
#' ebg <- expand_by_group(MetadataABA,
#'                        grp,
#'                        var1,
#'                        var2)
#'
#' SRratio <- calcSRratio(TranscriptomeABA,
#'                        var1,
#'                        var2,
#'                        ebg,
#'                        is.log2 = TRUE)
#'
#' head(calcSRscore(SRratio, threshold = c(-1, 1)))
#'
#' @export
calcSRscore <- function(srratio, threshold = c(-1, 1)) {

  cl <- sapply(srratio, function(x) {
    any(x > 0, na.rm = TRUE) && any(x < 0, na.rm = TRUE)
  })

  srratio_keep <- srratio[cl]

  thre <- srratio_keep <= threshold[1]
  dn <- rowSums(thre)

  thre <- srratio_keep >= threshold[2]
  up <- rowSums(thre)

  all <- ncol(srratio_keep)

  unchange <- all - up - dn

  score <- up - dn

  srscore <- cbind(up, dn, unchange, all, score)
  srscore <- as.data.frame(srscore)
  srscore <- cbind(Filter(is.character, srratio), srscore)
  srscore
}
