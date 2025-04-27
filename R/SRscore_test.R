#' Test data for calculating SRscore using sample data
#'
#'
#' A dataframe containing SRscore calculated from `SRratio_test`
#'
#'
#'
#' @format A data frame with 1000 rows and 10 variables:
#' \describe{
#'   \item{ensembl_gene_id}{Ensembl gene ID}
#'   \item{up1}{Total number of times SRratio exceeds 1}
#'   \item{up2}{Total number of times SRratio exceeds 2}
#'   \item{dn1}{Total number of times SRratio is below 1}
#'   \item{dn2}{Total number of times SRratio is below 2}
#'   \item{unchange1}{Total number of times SRratio is between -1 and 1}
#'   \item{unchange2}{Total number of times SRratio is between -2 and 2}
#'   \item{all}{Maximum possible SRscore}
#'   \item{SR1}{SRscore with absolute value 1 as threshold}
#'   \item{SR2}{SRscore with absolute value 2 as threshold}
#' }
#'
"SRscore_test"
