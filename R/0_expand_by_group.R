#' Create a data frame from all combinations between two specified variables within each group
#'
#' `expand_by_group()` generates all combinations (Cartesian product) of two specified variables within each group in your dataframe.
#'
#' @param .data A data frame.
#' @param grp A column name indicating the group.
#' @param var1 A column name indicating the control.
#' @param var2 A column name indicating the treatment.
#'
#' @return
#' Returns a data frame containing all combinations of the specified variables for each group.
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
