# When running Rscript install.R from the command line, it fails if no mirror is set. Use this line to the top of the script would solve it.
options(repos = c(CRAN = "https://cloud.r-project.org/"))

# devtools has a very large dependency tree that often breaks in Conda environments. Recommending remotes::install_github() is much safer and lighter for most users.
if (!requireNamespace("remotes", quietly = TRUE))
install.packages("remotes")
if (!requireNamespace("BiocManager", quietly = TRUE))
install.packages("BiocManager")
# Install Bioconductor dependencies first
BiocManager::install(c("ComplexHeatmap", "clusterProfiler", "org.At.tair.db", "genefilter", "BiocStyle"))

# Install SRscore (set build_vignettes = FALSE if Pandoc is not available)
pandoc_path <- Sys.which("pandoc")
if (pandoc_path != "") {
  install.packages(c("magick", "DT"))
  remotes::install_github("fusk-kpu/SRscore", build_vignettes = TRUE)
} else {
  remotes::install_github("fusk-kpu/SRscore", build_vignettes = FALSE)
}
