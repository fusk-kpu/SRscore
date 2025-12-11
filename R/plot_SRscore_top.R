#' Barplot of Top Genes Ranked by Absolute SRscore
#'
#' This function selects the top \code{top_n} genes with the largest absolute
#' SRscore values and visualizes their SRscores using a barplot.  
#' The function is useful for quickly identifying genes with the strongest
#' positive or negative stress responses.
#'
#' @param srscore A data.frame containing at least a column named \code{score},
#'   representing the SRscore values for genes.
#' @param top_n Integer (default: 20).  
#'   The number of top genes to plot, ranked by \code{|SRscore|}.
#'   
#' @importFrom graphics par barplot
#'
#' @return Invisibly returns the data.frame of selected top genes (after sorting).
#'   A barplot is produced as a side effect.
#'
#' @details
#' The function performs the following steps:
#' \itemize{
#'   \item Validates the input data structure.
#'   \item Computes absolute SRscore via \code{abs(score)}.
#'   \item Selects the top \code{top_n} genes with the largest absolute score.
#'   \item Re-sorts the selected genes by actual SRscore (to separate up/down).
#'   \item Produces a barplot in which gene names (character columns) are used as labels.
#' }
#'
#' The barplot displays:
#' \itemize{
#'   \item Positive SRscore (upregulated genes) as upward bars.
#'   \item Negative SRscore (downregulated genes) as downward bars.
#'   \item Genes ordered from lowest to highest SRscore for visual clarity.
#' }
#'
#' Graphical parameters are temporarily modified, and restored automatically
#' using \code{on.exit()} to avoid affecting the user's plotting environment.
#'
#' @examples
#' # Example data.frame of SRscore
#' df <- data.frame(
#'   gene = paste0("Gene", 1:10),
#'   score = c(-12, -6, -3, 1, 2, 3, 5, 8, 10, 11)
#' )
#'
#' # Plot top 5 genes by |SRscore|
#' plot_SRscore_top(df, top_n = 5)
#'
#' @export
plot_SRscore_top <- function(srscore, top_n = 20) {
  if(!is.data.frame(srscore)) 
    stop("srscore must be a data.frame")
  
  if(!all(c("score") %in% colnames(srscore))) 
    stop("srscore must contain columns 'score'")
  
  oldpar <- par(no.readonly = TRUE)
  on.exit(par(oldpar))

  par(mfrow = c(1,1))
  
  srscore$abs_score <- abs(srscore$score)
  top <- srscore[order(srscore$abs_score, decreasing = TRUE), ]
  top <- top[seq_len(min(top_n, nrow(srscore))), ]
  
  top <- top[order(top$score), ]
  
  barplot(
    height = top$score,
    names.arg = top[, sapply(top, is.character)],
    las = 2,
    cex.names = 0.7,
    ylab = "SRscore",
    main = paste0("Top ", nrow(top), " genes by |SRscore|")
  )
  
  invisible(top)
}
