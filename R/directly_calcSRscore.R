#' Aggregate the results of the three functions into a single list
#'
#' The SRscore calculation process is divided into three major processes, and functions are provided for each process (see the respective function documents for details).
#' `directly_calcSRscore()` aggregates the results of the three functions into a single list.
#'
#' @param .data1 A data frame containing the two variables you want to compare, as well as the variables of the group to which they belong.
#' @param var1 Column name of first variable.
#' @param var2 Column name of second variable.
#' @param grp Column name of groups.
#' @param .data2 A data frame containing expression values for a series of arrays, with rows corresponding to genes and columns to samples.
#' @param is.log A logical specifying if .data2 is log-transformed.
#'
#' @importFrom dplyr group_by filter_all all_vars %>%
#' @importFrom tidyr expand
#' @importFrom rlang sym
#' @importFrom utils menu
#' @importFrom Biobase exprs
#' @importFrom SummarizedExperiment assay
#'
#' @return A data frame containing results.
#'
#' @seealso [expand_by_group()]
#' @seealso [calcSRratio()]
#' @seealso [calcSRscore()]
#'
#' @examples
#' grp <- "Series"
#' var1 <- "control_sample"
#' var2 <- "treated_sample"
#'
#' ls <- directly_calcSRscore(MetadataABA,
#'                            grp,
#'                            var1,
#'                            var2,
#'                            TranscriptomeABA,
#'                            is.log = TRUE)
#' lapply(ls, head)
#'
#' @export
directly_calcSRscore <- function(.data1, grp, var1, var2, .data2, is.log = NA) {

  # Creating a data frame including all possible pairs of two variables within each groups.
  . <- NULL
  pairs <- .data1 %>%
    group_by(!!sym(grp)) %>%
    expand(!!sym(var1), !!sym(var2)) %>%
    filter_all(all_vars(!is.na(.))) %>%
    as.data.frame()

  f <- function(x) gsub("-", "_", x)
  colnames(.data2) <- f(colnames(.data2))
  pairs <- data.frame(apply(pairs, 2, f))

  ratio <- function(i){
    var2_side <- pairs[i, var2]
    var1_side <- pairs[i, var1]
    if (is.na(is.log)) {
      switch (
        menu(c("yes", "no"), title = "Is the data log-transformed?"),
        {.data2[, var2_side] - .data2[, var1_side]},
        {log2((.data2[, var2_side] + 1) / (.data2[, var1_side] + 1))}
      )
    } else if (is.log == TRUE) {
      .data2[, var2_side] - .data2[, var1_side]
    } else if (is.log == FALSE) {
      log2((.data2[, var2_side] + 1) / (.data2[, var1_side] + 1))
    }
  }

  SRratio <- data.frame(ratio(1:nrow(pairs)))

  SRratio_mean <- Filter(is.character, .data2)
  var2_samples <- unique(as.vector(pairs[var2])[[var2]])

  for (i in seq_along(var2_samples)) {
    grp <- grep(var2_samples[i], colnames(SRratio))
    if (length(grp) > 1) {
      SRratio_mean <- cbind(SRratio_mean, rowMeans(SRratio[, grp]))
    } else {
      SRratio_mean <- cbind(SRratio_mean, SRratio[, grp])
    }
  }

  colnames(SRratio_mean) <- c(names(Filter(is.character, .data2)),
                              unique(gsub("\\..+", "", unique(colnames(SRratio)))))

  SRratio_keep <- Filter(is.numeric, SRratio_mean)

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
  SRscore <- cbind(Filter(is.character, SRratio_mean), SRscore)
  list(pairs = pairs,
       SRratio = SRratio_mean,
       SRscore = SRscore)
}
