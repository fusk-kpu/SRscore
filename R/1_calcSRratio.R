#' Calculate the Stress Response ratio (SRratio)
#'
#' This function computes the Stress Response ratio (SR ratio) for paired variables in a dataset.
#' The function supports both log2-transformed and non-log2-transformed data and calculates the mean SRratio for grouped variables.
#'
#' @param .data A data frame containing expression values for a series of arrays, with rows corresponding to genes and columns to samples.
#' @param var1 A character vector containing column names of control samples.
#' @param var2 A character vector containing column names of treatment samples.
#' @param pair A data frame with control samples and treatment samples.
#' @param is.log2 A logical value (TRUE, FALSE) or NA indicating whether the data in .data is log2-transformed:
#' * If TRUE, the SR ratio is calculated as the difference between the target and reference variables.
#' * If FALSE, the SR ratio is calculated as the log2-transformed ratio: log2((target + 1) / (reference + 1)).
#' * If NA (default), the user will be prompted interactively to confirm whether the data is log-transformed.
#'
#' @importFrom utils menu
#'
#' @return A data frame containing:
#' * Character columns from the original .data.
#' * Mean SRratio values for each unique target variable.
#'
#' @examples
#' var1 <- "control_sample"
#' var2 <- "treated_sample"
#' grp <- "Series"
#'
#' ebg <- expand_by_group(MetadataABA, grp, var1, var2)
#'
#' SRratio <- calcSRratio(TranscriptomeABA, var1, var2, ebg, is.log2 = TRUE)
#'
#' @export
calcSRratio <- function(.data, var1, var2, pair, is.log2 = NA) {

  f <- function(x) gsub("-", "_", x)
  colnames(.data) <- f(colnames(.data))
  pair <- data.frame(apply(pair, 2, f))

  ratio <- function(i){

    t <- pair[i, var2]
    c <- pair[i, var1]

    if (is.na(is.log2)) {
    switch (
      menu(c("yes", "no"), title = "Is the data log2-transformed?"),
         {.data[, t] - .data[, c]},
         {log2((.data[, t] + 1) / (.data[, c] + 1))}
         )
    } else if (is.log2 == TRUE) {
      .data[, t] - .data[, c]
    } else if (is.log2 == FALSE) {
      log2((.data[, t] + 1) / (.data[, c] + 1))
    }
  }
  SRratio <- data.frame(ratio(1:nrow(pair)))

  cl <- setdiff(colnames(.data), c(pair[, var1], pair[, var2]))
  SRratio_mean <- .data[cl]
  treated_sample <- unique(as.vector(pair[var2])[[var2]])

  for (i in seq_along(treated_sample)) {
    grp <- grep(treated_sample[i], colnames(SRratio))
    if (length(grp) > 1) {
      SRratio_mean <- cbind(SRratio_mean, rowMeans(SRratio[, grp]))
    } else {
      SRratio_mean <- cbind(SRratio_mean, SRratio[, grp])
    }
  }

  colnames(SRratio_mean) <- c(cl, unique(gsub("\\..+", "", colnames(SRratio))))
  SRratio_mean
}
