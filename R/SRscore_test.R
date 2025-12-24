#' Test data for calculating SRscore using sample data
#'
#'
#' A dataframe containing SRscore (Stress Response score) calculated
#' from `SRratio_test`.
#'
#'
#'
#' @format A data frame with 1000 rows and 6 variables:
#' \describe{
#'   \item{ensembl_gene_id}{Ensembl gene ID}
#'   \item{up}{Total number of times SRratio exceeds 2}
#'   \item{dn}{Total number of times SRratio is below 2}
#'   \item{unchange}{Total number of times SRratio is between -2 and 2}
#'   \item{all}{Maximum possible SRscore}
#'   \item{score}{SRscore with absolute value 2 as threshold}
#' }
#'
"SRscore_test"
