#' Reproducing HN-scores from HN-ratios Using the SRscore Package
#'
#' The HN-ratio, which quantifies gene expression changes between 
#' hypoxic and normoxic conditions across multiple experiments, was originally 
#' proposed by Tamura and Bono (2022) <doi:10.3390/life12071079>.
#' It is publicly available on figshare <doi:10.6084/m9.figshare.20055086>. 
#' In the SRscore package, the HN-ratio is introduced solely as 
#' an intermediate quantity required to compute HN-scores.
#' `logHNratioHypoxia` is a data frame containing log2-transformed HN-ratios. 
#' To reduce data size, `logHNratioHypoxia` includes HN-ratios for a subset of
#'  1,000 genes extracted from the original dataset.
#'
#' Column components :
#'
#'  Ensembl gene id + 29 treatment sample id
#'
#' @source Tamura, Keita, and Hidemasa Bono. 2022. “Meta-Analysis of RNA Sequencing Data of Arabidopsis and Rice Under Hypoxia.” Life 12 (7).
#'
"logHNratioHypoxia"
