#' Calculate the Stress Response ratio (SRratio)
#'
#' This function computes the Stress Response ratio (SR ratio) for paired variables in a dataset.
#' The function supports both log-transformed and non-log-transformed data and calculates the mean SRratio for grouped variables.
#'
#' @param .data A data frame containing expression values for a series of arrays, with rows corresponding to genes and columns to samples.
#' @param var1 A character vector containing column names of control samples.
#' @param var2 A character vector containing column names of treatment samples.
#' @param pair A data frame with control samples and treatment samples.
#' @param is.log A logical value (TRUE, FALSE) or NA indicating whether the data in .data is log-transformed:
#' * If TRUE, the SR ratio is calculated as the difference between the target and reference variables.
#' * If FALSE, the SR ratio is calculated as the log2-transformed ratio: log2((target + 1) / (reference + 1)).
#' * If NA (default), the user will be prompted interactively to confirm whether the data is log-transformed.
#'
#' @importFrom utils menu
#' @importFrom Biobase exprs
#' @importFrom SummarizedExperiment assay
#'
#' @return A data frame containing:
#' * Character columns from the original .data.
#' * Mean SRratio values for each unique target variable.
#'
#' @examples
#' data1 <- data.frame(
#'   group = c("A", "A", "B", "B"),
#'   var1 = c("a", "b", "c", "d"),
#'   var2 = c("x", "y", "z", NA)
#' )
#'
#' ebg <- expand_by_group(data1, "group", "var1", "var2")
#'
#' data2 <- data.frame(
#'   Gene = c("Gene1", "Gene2", "Gene3"),
#'   a = c(10, 15, 20),
#'   b = c(20, 25, 30),
#'   c = c(25, 30, 35),
#'   d = c(30, 35, 40),
#'   x = c(35, 40, 45),
#'   y = c(40, 45, 50),
#'   z = c(45, 50, 55)
#' )
#'
#' result <- calcSRratio(data2, "var1", "var2", ebg, is.log = FALSE)
#' print(result)
#'
#' var1 <- "control_sample"
#' var2 <- "treated_sample"
#' grp <- "Series"
#'
#' ebg <- expand_by_group(MetadataABA, var1, var2, grp)
#'
#' SRratio <- calcSRratio(TranscriptomeABA, var1, var2, ebg, is.log = TRUE)
#'
#' @export
calcSRratio <- function(.data, var1, var2, pair, is.log = NA) {

  f <- function(x) gsub("-", "_", x)
  colnames(.data) <- f(colnames(.data))
  pair <- data.frame(apply(pair, 2, f))

  ratio <- function(i){

    t <- pair[i, var2]
    c <- pair[i, var1]

    if (is.na(is.log)) {
    switch (
      menu(c("yes", "no"), title = "Is the data log-transformed?"),
         {.data[, t] - .data[, c]},
         {log2((.data[, t] + 1) / (.data[, c] + 1))}
         )
    } else if (is.log == TRUE) {
      .data[, t] - .data[, c]
    } else if (is.log == FALSE) {
      log2((.data[, t] + 1) / (.data[, c] + 1))
    }
  }

  SRratio <- data.frame(ratio(1:nrow(pair)))

  SRratio_mean <- Filter(is.character, .data)
  treated_sample <- unique(as.vector(pair[var2])[[var2]])

  for (i in seq_along(treated_sample)) {
    grp <- grep(treated_sample[i], colnames(SRratio))
    if (length(grp) > 1) {
      SRratio_mean <- cbind(SRratio_mean, rowMeans(SRratio[, grp]))
    } else {
      SRratio_mean <- cbind(SRratio_mean, SRratio[, grp])
    }
  }

  colnames(SRratio_mean) <- c(names(Filter(is.character, .data)),
                              unique(gsub("\\..+", "", unique(colnames(SRratio)))))
  SRratio_mean
}
