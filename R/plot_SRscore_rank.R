#' Plot Ranked SRscore Values with Threshold-Based Highlighting
#'
#' This function visualizes SRscore values sorted in descending order and colors
#' each point based on user-defined thresholds.  
#' Genes with SRscore above the upper threshold are colored red (up-regulated),
#' those below the lower threshold are colored blue (down-regulated),
#' and values within the range are shown in black.
#'
#' @param srscore A data.frame containing at least a column named \code{score},
#'   representing SRscore values for genes.
#' @param threshold A numeric vector of length 2 specifying  
#'   \code{c(upper_threshold, lower_threshold)}.  
#'   Default is \code{c(1, -1)}.
#'   
#' @importFrom graphics par legend
#'
#' @return Invisibly returns the sorted SRscore vector.  
#'   The function produces a scatter plot as a side effect.
#'
#' @details
#' The function performs the following:
#' \itemize{
#'   \item Validates input data.
#'   \item Sorts SRscore values in descending order.
#'   \item Colors each point based on whether its value is:
#'      \itemize{
#'        \item greater than or equal to the upper threshold (red)
#'        \item less than or equal to the lower threshold (blue)
#'        \item between the thresholds (black)
#'      }
#'   \item Produces a rank plot with a legend explaining the color mapping.
#' }
#'
#' @examples
#' df <- data.frame(
#'   gene = paste0("Gene", 1:10),
#'   score = c(-5, -3, -1, 0, 0.5, 1.2, 2, 3, 4, 5)
#' )
#'
#' # Basic usage
#' plot_SRscore_rank(df)
#'
#' # Custom thresholds
#' plot_SRscore_rank(df, threshold = c(2, -2))
#'
#' @export
plot_SRscore_rank <- function(srscore, threshold = c(1, -1)) {
  
  if(!is.data.frame(srscore)) 
    stop("srscore must be a data.frame")
  
  if(!all(c("score") %in% colnames(srscore))) 
    stop("srscore must contain columns 'score'")
  
  oldpar <- par(no.readonly = TRUE)
  on.exit(par(oldpar))
  
  par(mfrow = c(1,1))
  
  if (threshold[1] < threshold[2]) {
    threshold <- sort(threshold, decreasing = TRUE)
  }
  
  threshold <- c(up = threshold[1], down = threshold[2])
  
  sort_score <- sort(srscore$score, decreasing = TRUE)
  
  suppressWarnings({
    plot(sort_score, 
         col = ifelse(sort_score >= threshold[1], "red",
                      ifelse(sort_score <= threshold[2], "blue", "black")),
         main = "Distribution of Sorted SRscore",
         xlab = "Rank (sorted genes)",
         ylab = "SRscore")
    
    legend(
      "topright",
      legend = c(
        paste0("Up-regulated (\u2265 ", threshold[1], ")"),
        paste0("Down-regulated (\u2264 ", threshold[2], ")"),
        "No significant change"
        ),
      col = c("red", "blue", "black"),
      pch = 1,
      pt.cex = 1,
      bty = "n"
      )
  })
}
