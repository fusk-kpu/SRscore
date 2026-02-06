# *SRscore*

An R package for simple transcriptome meta-analysis for identifying stress-responsive genes

Stress Response score (SRscore) is a stress responsiveness measure for transcriptome datasets and is based on the vote-counting method.
The SRscore is determined to evaluate and scores genes on the basis of the consistency of the direction of their regulation (Up-regulation, Down-regulation, or No changed) under stress conditions across the analyzed, multiple research projects. 
This package is based on the HN-score of [Tamura and Bono (2022)](https://doi.org/10.3390/life12071079), and can calculate both the original method and the calculation method we have extended ([Fukuda et al. 2025](https://doi.org/10.1093/plphys/kiaf105)).

## System-level dependencies

### For Windows users

*SRscore* package requires not only R but also Rtools to be installed beforehand.
Please download Rtools from [https://cran.r-project.org/bin/windows/Rtools/](https://cran.r-project.org/bin/windows/Rtools/) and install it before installing *SRscore* package.

### For macOS users (important)

On recent macOS versions, XQuartz (X11) is not installed by default.

Missing XQuartz may cause errors such as:

```
cannot load shared object 'R_X11.so'
```

To avoid this, install XQuartz from [https://www.xquartz.org/](https://www.xquartz.org/) .
After installation, restart your system or log out/in, then proceed to "One-Stop" installation.

### For Ubuntu Linux users

There are several system-level software packages required to install the R packages that *SRscore* package depends on.
Before installing *SRscore* package, please install these prerequisites using the following command in your bash shell.

```
sudo apt install -y libcurl4-openssl-dev libssl-dev libxml2-dev libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev libfontconfig1-dev libharfbuzz-dev libfribidi-dev libwebp-dev pkg-config build-essential gfortran libcairo2-dev libglpk-dev pandoc libmagick++-dev
```

## Pandoc dependency

Pandoc is required if you install *SRscore* package from this GitHub repository rather than CRAN, and build the documentation locally.

In that case, please follow Instruction [https://pandoc.org/installing.html](https://pandoc.org/installing.html) and install Pandoc for your operating system.

## "One-Stop" installation

"Installing from CRAN" is strongly recommended, particularly on Windows and macOS.

### Installing from CRAN

*SRscore* package is available on CRAN [https://cran.r-project.org/web/packages/SRscore/](https://cran.r-project.org/web/packages/SRscore/) .
To install it from CRAN, please run the following command in your R console.

```R
# When running Rscript install.R from the command line, it fails if no mirror is set. Use this line to the top of the script would solve it.
options(repos = c(CRAN = "https://cloud.r-project.org/"))

if (!requireNamespace("BiocManager", quietly = TRUE))
install.packages("BiocManager")
# Install Bioconductor dependencies first
BiocManager::install(c("ComplexHeatmap", "clusterProfiler", "org.At.tair.db", "genefilter", "BiocStyle"))

install.packages("SRscore")
```

### Installing from this GitHub repository

```R
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
```


Documents
------------
```R
library(SRscore)
browseVignettes("SRscore")
```

The *SRscore* package is designed to facilitate meta-analysis 
methods based on vote-counting. 
It contains three main functions for calculating the SRscore, 
which represents a numerical value indicating a gene's stress 
responsiveness among multiple studies. 
Using the `expand_by_groups()` function, 
it is possible to generate a table pairing all possible combinations of two groups, 
which can be arranged in two columns. To mitigate batch effects,
the function only generates pairs among samples within a given dataset (e.g., NCBI GEO series). 
When the table thus acquired is used as an input to execute the `calc_SRratio()` function,
this function calculates a value designated the Stress Response ratio (SRratio) and, 
which is stored in an SRratio matrix (gene × sample). 
SRratio represents the gene expression level and is calculated similarly to a log2 fold change.
Using this matrix as an input, executing the `calc_SRscore()` function yields a gene-specific SRscore.

The primary feature of the *SRscore* package is its capacity to perform cross-comparative analysis
of multiple datasets and to estimate consistent changes in gene expression levels.
Commencing with the import of metadata and expression data, 
the package implements a sequential workflow that includes inter-group comparisons within each dataset, 
calculation of integrated scores via meta-analysis, and visualization and export of the results.

Updates
------------
#### A detailed update to the README.md in this repository (February 4, 2026)
#### version 0.1.2 (December 17, 2025)

License
------------
MIT
