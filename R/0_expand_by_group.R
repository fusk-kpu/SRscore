#' Create a data frame from all combinations between conditions by each research project
#'
#' You need to supply a data frame and at least three variables in the dataframe.
#' This is useful when creating a data frame from all combinations of
#' control conditions and treatment conditions across research projects.
#'
#' @param .data A data frame containing at least three variables.
#' @param cnt An unquoted expression specifying the column of control conditions.
#' @param trt An unquoted expression specifying the column of treatment conditions.
#' @param .by An unquoted expression specifying the column of research projects.
#'
#' @return
#' A data frame containing one row for each combination of the specified conditions.
#'
#' @importFrom dplyr enquo group_by filter_all all_vars %>%
#' @importFrom tidyr expand
#'
#' @examples
#' ebg <- expand_by_group(MetadataABA,
#'                        control_sample,
#'                        treated_sample,
#'                        Series)
#'
#' unique_series <- unique(MetadataABA$Series)
#'
#' lapply(unique_series,
#'        function(x) subset(ebg, Series == x))
#'
#'
#' @export
expand_by_group <- function(.data, cnt, trt, .by) {

  cnt <- enquo(cnt)
  trt <- enquo(trt)
  .by <- enquo(.by)

  tbl <- .data %>% group_by(!!.by) %>% expand(!!cnt, !!trt)
  tbl <- as.data.frame(tbl)
  filter_all(tbl, all_vars(!is.na(.)))
}
