#' Create a Data Frame of SRratio
#'
#' SRratio is the gene expression ratios between the control samples and
#' treatment samples across all combinations within a research project.
#'
#' @param .data A data frame with columns representing feature and samples.
#' @param control A character vector containing column names of control samples.
#' @param treatment A character vector containing column names of treatment samples.
#' @param sample_pair A data frame with control samples and treatment samples.
#' @param is.logarithmic A logical specifying if .data is log-transformed.
#'
#' @importFrom utils menu
#' @importFrom Biobase exprs
#' @importFrom SummarizedExperiment assay
#'
#' @return SRratio
#' @examples
#' ebg <- expand_by_group(MetadataABA, control_sample, treated_sample, Series)
#'
#' SRratio <- calculate_SRratio(TranscriptomeABA, "control_sample",
#'                              "treated_sample", ebg, is.logarithmic = 1)
#'
#' @export
calculate_SRratio <- function(.data, control, treatment, sample_pair, is.logarithmic = NA) {

  if (class(.data) == "ExpressionSet") {
    .data <- exprs(.data)
  } else if (class(.data) == "RangedSummarizedExperiment") {
    .data <- assay(.data)
  }

  f <- function(x) gsub("-", "_", x)
  colnames(.data) <- f(colnames(.data))
  sample_pair <- data.frame(apply(sample_pair, 2, f))

  ratio <- function(i){

    t <- sample_pair[i, treatment]
    c <- sample_pair[i, control]

    if (is.na(is.logarithmic)) {
    switch (
      menu(c("yes", "no"), title = "Is the data log-transformed?"),
         {.data[, t] - .data[, c]},
         {log2((.data[, t] + 1) / (.data[, c] + 1))}
         )
    } else if (is.logarithmic == TRUE) {
      .data[, t] - .data[, c]
    } else if (is.logarithmic == FALSE) {
      log2((.data[, t] + 1) / (.data[, c] + 1))
    }
  }

  SRratio <- data.frame(ratio(1:nrow(sample_pair)))

  SRratio_mean <- Filter(is.character, .data)
  treated_sample <- unique(as.vector(sample_pair[treatment])[[treatment]])

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
