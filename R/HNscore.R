#' Test data for calculating HNscore using sample data
#'
#' HNscore was calculated to evaluate the changes in the gene expression under hypoxia across the experiments.
#' A dataframe containing HNscore calculated from `logHNratioHypoxia`.
#'
#'
#'
#' @format A data frame with 1000 rows and 11 variables:
#' \describe{
#'   \item{Transcript_id_At}{Transcript ID in *Arabidopsis thaliana*}
#'   \item{Upregulated}{Total number of times HNratio exceeds 2}
#'   \item{Downregulated}{Total number of times HNratio is below 0.5}
#'   \item{Unchanged}{Total number of times SRratio is between 0.5 and 2}
#'   \item{All}{Maximum possible HNscore}
#'   \item{HN.score}{HNscore}
#'   \item{Gene_name_At}{Gene name in *Arabidopsis thaliana*}
#'   \item{Gene_description_At}{Gene description in *Arabidopsis thaliana*}
#'   \item{Protein_id_Hs}{Transcript ID in *Homo Sapiens*}
#'   \item{Gene_name_Hs}{Gene name in *Homo Sapiens*}
#'   \item{Gene_description_Hs}{Gene name in *Homo Sapiens*}
#' }
#'
#' @source Tamura, Keita, and Hidemasa Bono. 2022. “Meta-Analysis of RNA Sequencing Data of Arabidopsis and Rice Under Hypoxia.” Life 12 (7).
#'
"HNscore"
