#' Reproducing HN-scores from HN-ratios Using the SRscore Package
#'
#' The HN-score is a scoring metric derived from the HN-ratio, which represents
#' the gene expression ratio between hypoxic and normoxic conditions, and was 
#' originally proposed by Tamura and Bono (2022) <doi:10.3390/life12071079>.
#' It is publicly available on figshare <doi:10.6084/m9.figshare.20055086>.
#' `HNscore` is provided as a data frame containing HN-scores calculated from 
#' `logHNratioHypoxia` and is implemented as test data in the SRscore package.
#' To reduce data size, `HNscore` includes HN-scores for a subset of 
#' 1,000 genes extracted from the original dataset.
#'
#' @format A data frame with 1000 rows and 11 variables:
#' \describe{
#'   \item{Transcript_id_At}{Transcript ID in *Arabidopsis thaliana*}
#'   \item{Upregulated}{Total number of times HNratio exceeds 2}
#'   \item{Downregulated}{Total number of times HNratio is below 0.5}
#'   \item{Unchanged}{Total number of times SRratio is between 0.5 and 2}
#'   \item{All}{Maximum possible HNscore}
#'   \item{HN.score}{HN-score}
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
