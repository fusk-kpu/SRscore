#' Create a Data Frame of SRscore
#'
#' SRscore is score value of genes based expression profiles across different research projects.
#' SRratio is required to calculate SRscore.
#'
#' @param SRratio A data frame of SRratio.
#' @param threshold A vector of length 2 (x, y) indicating threshold values. `c(-2, 2)` is default.
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
#'                        is.log = 1)
#'
#' head(calcSRscore(SRratio))
#'
#' @export
calcSRscore <- function(SRratio, threshold = c(-2, 2)) {
  SRratio_keep <- Filter(is.numeric, SRratio)

  thre <- SRratio_keep <= threshold[1]
  dn <- rowSums(thre)

  thre <- SRratio_keep >= threshold[2]
  up <- rowSums(thre)

  all <- ncol(SRratio_keep)

  unchange <- all - up - dn

  score <- up - dn

  SRscore <- cbind(up, dn, unchange, all, score)
  SRscore <- as.data.frame(SRscore)
  SRscore <- cbind(Filter(is.character, SRratio), SRscore)
  SRscore
}
