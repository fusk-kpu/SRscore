SRscore
========
An R package for simple transcriptome meta-analysis for identifying stress-responsive genes

Stress Response score (SRscore) is a stress responsiveness measure for transcriptome datasets and is based on the vote-counting method. The SRscore is determined to evaluate and scores genes on the basis of the consistency of the direction of their regulation (Up-regulation, Down-regulation, or No changed) under stress conditions across the analyzed, multiple research projects. This package is based on the HN-score of [Tamura and Bono (2022)](https://www.mdpi.com/2075-1729/12/7/1079), and can calculate both the original method and the calculation method we have extended ([Fukuda et al. 2025](https://doi.org/10.1093/plphys/kiaf105)).

Installation
------------
```R
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install(c("ComplexHeatmap", "clusterProfiler", 
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

Updates
------------
#### version 0.1.0 (May 7, 2025)

License
------------
MIT