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
calcSRscore <- function(SRratio) {
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
