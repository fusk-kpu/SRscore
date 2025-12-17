SRscore
========
An R package for simple transcriptome meta-analysis for identifying stress-responsive genes

Stress Response score (SRscore) is a stress responsiveness measure for transcriptome datasets and is based on the vote-counting method. The SRscore is determined to evaluate and scores genes on the basis of the consistency of the direction of their regulation (Up-regulation, Down-regulation, or No changed) under stress conditions across the analyzed, multiple research projects. This package is based on the HN-score of [Tamura and Bono (2022)](https://www.mdpi.com/2075-1729/12/7/1079), and can calculate both the original method and the calculation method we have extended ([Fukuda et al. 2025](https://doi.org/10.1093/plphys/kiaf105)).

Installation
------------
```R
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install(c("BiocStyle", "ComplexHeatmap", "clusterProfiler", 
                       "org.At.tair.db", "genefilter"))

install.packages(c("RColorBrewer", "DT"))

install.packages("devtools")
devtools::install_github("fusk-kpu/SRscore", build_vignettes = TRUE)
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
#### version 0.1.2 (December 17, 2025)

License
------------
MIT
