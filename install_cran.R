# When running Rscript install.R from the command line, it fails if no mirror is set. Use this line to the top of the script would solve it.
options(repos = c(CRAN = "https://cloud.r-project.org/"))

if (!requireNamespace("BiocManager", quietly = TRUE))
install.packages("BiocManager")
# Install Bioconductor dependencies first
BiocManager::install(c("ComplexHeatmap", "clusterProfiler", "org.At.tair.db", "genefilter", "BiocStyle"))

install.packages("SRscore")
