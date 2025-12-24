#' Test data for the SRscore package
#'
#' SRGA is a reference test dataset that integrates standardized SRscores across
#' 11 stress conditions as reported in Fukuda et al. (2025) <doi:10.1093/plphys/kiaf105>.
#' Because SRscore scales differ by stress type, SRscores were standardized using z-scores.
#' This dataset is provided solely for demonstrating and testing
#' template matching (Pavlidis and Noble, 2001) <doi:10.1186/gb-2001-2-10-research0042> 
#' workflows implemented in the SRscore package and is not intended to 
#' introduce a new analysis method.
#' To reduce file size, the dataset includes SRscores for a subset of 1,000 genes.
#'
#'
#' @format A data frame with 1000 rows and 13 variables:
#' \describe{
#'   \item{ensembl_gene_id}{Ensembl gene ID}
#'   \item{ABA}{SRscore derived from ABA dataset}
#'   \item{Cold}{SRscore derived from cold dataset}
#'   \item{DC3000}{SRscore derived from DC3000 dataset}
#'   \item{Drought}{SRscore derived from drought dataset}
#'   \item{Heat}{SRscore derived from heat dataset}
#'   \item{High-light}{SRscore derived from highlight dataset}
#'   \item{Hypoxia}{SRscore derived from hypoxia dataset}
#'   \item{Osmotic}{SRscore derived from osmotic dataset}
#'   \item{Oxidation}{SRscore derived from oxidation dataset}
#'   \item{Salt}{SRscore derived from salt dataset}
#'   \item{Wound}{SRscore derived from wound dataset}
#'   \item{SYMBOL}{Gene symbol}
#' }
#'
#'
"SRGA"
