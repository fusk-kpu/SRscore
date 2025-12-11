#' Plot the Distribution of SRscore Values
#'
#' This function visualizes the distribution of SRscore values using a barplot.  
#' Values equal to 0 are excluded from the plot by design because they typically represent
#' genes without detectable stress response activity.  
#'
#' The function provides both a linear-scale plot and a log-scale version, which is
#' particularly useful when the frequency of SRscore values spans a wide range.
#'
#' @param srscore A data.frame containing at least one column named \code{score},
#'   which represents the SRscore values to be plotted.
#' @param log Logical (default: \code{FALSE}).  
#'   If \code{TRUE}, the y-axis of the barplot is shown in logarithmic scale (\code{log = "y"}).
#'
#' @importFrom graphics par barplot
#'
#' @return This function returns \code{NULL} invisibly and produces a barplot as a side effect.
#'
#' @details
#' The function performs the following steps:
#' \itemize{
#'   \item Validates that \code{srscore} is a data.frame and contains a \code{score} column.
#'   \item Removes SRscore values equal to 0.
#'   \item Produces a barplot of the frequency of SRscore values.
#'   \item Optionally draws the plot on a logarithmic y-axis.
#' }
#'
#' @examples
#' # Example SRscore data
#' df <- data.frame(score = c(-5, -3, -3, 1, 2, 2, 2, 4, 5, 5, 0))
#'
#' # Linear-scale plot
#' plot_SRscore_distr(df)
#'
#' # Log-scale plot
#' plot_SRscore_distr(df, log = TRUE)
#'
#' @export
plot_SRscore_distr <- function(srscore, log = FALSE) {
  
  if(!is.data.frame(srscore)) 
    stop("srscore must be a data.frame")
  
  if(!all(c("score") %in% colnames(srscore))) 
    stop("srscore must contain columns 'score'")
  
  oldpar <- par(no.readonly = TRUE)
  on.exit(par(oldpar))

  par(mfrow = c(1,1))
  
  if(log == FALSE){
    barplot(
      table(srscore$score)[names(table(srscore$score)) != "0"],
      xlab = "SRscore",
      ylab = "Number of genes",
      main = "Distribution of SRscore excluding 0"
    )
  }
  
  if(log == TRUE){
    barplot(
      table(srscore$score)[names(table(srscore$score)) != "0"],
      log = "y",
      xlab = "SRscore",
      ylab = "log10(Number of genes)",
      main = "Distribution of SRscore excluding 0"
    )
  }
}
