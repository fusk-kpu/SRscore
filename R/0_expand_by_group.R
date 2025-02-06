#' Create a data frame from all combinations between two specified variables within each group
#'
#' This function generates all combinations (Cartesian product) of two specified variables within each group of a given dataset.
#' The resulting dataset is returned as a data frame, with rows containing NA values automatically filtered out.
#'
#'
#' @param .data A data frame. The dataset to be processed.
#' @param grp The variable (column name) used for grouping. Specify as a string.
#' @param var1 The first variable to compare (column name). Specify as a string.
#' @param var2 The second variable to compare (column name). Specify as a string.
#'
#' @return
#' Returns a data frame containing all combinations of the specified variables (vr1 and vr2) for each group.
#' The structure of the returned data frame includes:
#'
#' * All combinations of `var1` and `var2` within each group.
#' * The group column (`grp`).
#' * Rows with NA values removed.

#'
#' @importFrom dplyr group_by filter_all all_vars %>%
#' @importFrom tidyr expand
#' @importFrom rlang sym
#'
#' @examples
#' data <- data.frame(
#'   group = c("A", "A", "B", "B"),
#'   var1 = c("a", "b", "c", "d"),
#'   var2 = c("x", "y", "z", NA)
#' )
#'
#' result <- expand_by_group(data, "group", "var1", "var2")
#'
#' print(result)
#'
#' grp <- "Series"
#' var1 <- "control_sample"
#' var2 <- "treated_sample"
#'
#' ebg <- expand_by_group(MetadataABA,
#'                        grp,
#'                        var1,
#'                        var2)
#'
#' unique_series <- unique(MetadataABA$Series)
#'
#' lapply(unique_series,
#'        function(x) subset(ebg, Series == x))
#'
#'
#' @export
expand_by_group <- function(.data, grp, var1, var2) {
  . <- NULL
  .data %>%
    group_by(!!sym(grp)) %>%
    expand(!!sym(var1), !!sym(var2)) %>%
    filter_all(dplyr::all_vars(!is.na(.))) %>%
    as.data.frame()
}
