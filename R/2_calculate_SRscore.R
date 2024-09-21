#' Create a Data Frame of SRscore
#'
#' SRscore is score value of genes based expression profiles across different research projects.
#' SRratio is required to calculate SRscore.
#'
#' @param SRratio A data frame of SRratio.
#'
#' @return A data frame containing results.
#'
#' @examples
#' ebg <- expand_by_group(MetadataABA, control_sample, treated_sample, Series)
#'
#' SRratio <- calculate_SRratio(TranscriptomeABA, "control_sample",
#'                              "treated_sample", ebg, is.logarithmic = 1)
#'
#' head(calculate_SRscore(SRratio))
#'
#' @export
calculate_SRscore <- function(SRratio) {
  SRratio_keep <- Filter(is.numeric, SRratio)

  thre <- SRratio_keep >= 1
  up1 <- rowSums(thre)

  thre <- SRratio_keep >= 2
  up2 <- rowSums(thre)

  thre <- SRratio_keep <= -1
  dn1 <- rowSums(thre)

  thre <- SRratio_keep <= -2
  dn2 <- rowSums(thre)

  all <- ncol(SRratio_keep)

  unchange1 <- all - up1 - dn1
  unchange2 <- all - up2 - dn2

  SR1 <- up1 - dn1
  SR2 <- up2 - dn2

  SRscore <- cbind(up1, up2, dn1, dn2, unchange1, unchange2, all, SR1, SR2)
  SRscore <- as.data.frame(SRscore)
  SRscore <- cbind(Filter(is.character, SRratio), SRscore)
  SRscore
}
