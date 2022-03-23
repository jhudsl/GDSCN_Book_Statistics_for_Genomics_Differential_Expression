# (PART\*) DIFFERENTIAL EXPRESSION {-}

# Transformation & MA Plots 

## Overview

The following excerpt comes from @Ritchie2015 : 

> _Measuring expression in multiple RNA samples produces columns of correlated expression values, which are highly correlated because they are measured on the same set of genes or genomic features. It has long been established in the biomedical literature that the level of agreement between correlated variables can be usefully examined by plotting differences versus means._

In other words, gene expression data is full of correlations. We must think carefully about how we examine and plot gene expression data. In the next steps, we will:

- Examine how $\log_{2}$ transformations and fold-change improve data clarity
- Learn how to make MA plots on gene expression data

Much of the following has been adopted from the [`Glimma` vignette](https://bioconductor.org/packages/release/bioc/vignettes/Glimma/inst/doc/limma_edger.html) for `limma` and `edgeR` [@Su2017]. 

## Gene Expression Data

First, we will load the necessary packages.




```r
# Install and load Glimma, limma, and matrixStats
# BiocManager::install(c("Glimma", "limma"))
library(Glimma)
library(limma)
library(matrixStats)
```

Load the gene expression data. We will be using data from @Sheridan2015 that has already been vetted to demo plot creation. This experiment consists of three cell populations - basal, luminal progenitor (LP) and mature luminal (ML) - sorted from mice mammary glands. Each treatment consists of three replicates. The gene expression data is stored in a special list-based data class called a "DGEList" (this stands for Digital Gene Expression).


```r
# Load the gene expression data
dge <- readRDS(system.file("RNAseq123/dge.rds", package = "Glimma"))
head(dge$counts,10)
```

```
##        10_6_5_11 9_6_5_11 purep53 JMS8-2 JMS8-3 JMS8-4 JMS8-5 JMS9-P7c JMS9-P8c
## 497097         1        2     342    526      3      3    535        2        0
## 20671          1        1      76     40     33     14     98       18        8
## 27395        431      771    1368   1268   1564    769    818      468      342
## 18777        768     1722    2517   1923   3865   1888   1830     1246      693
## 21399        810      977    2472   1870   2251   1716   1932      756      619
## 58175        452      358      17     14    622    571     12      203      224
## 108664      1716     2678    2097   2071   5499   3630   1731     1715     1251
## 12421       3451     2699    3399   2716   5233   6280   3647     1866     2122
## 319263      2026     2033    3920   2715   3873   3688   3593     1609     1348
## 59014        956      985    5497   4214   3462   2933   5336      649      731
```

In this data, each sample is in a column, while each gene is in a row. These raw counts range from very small to quite large numbers!

## Plotting Raw Counts

Let's say we want to compare basal and LP samples. We will first look at the metadata.


```r
# View metadata
dge$samples
```

```
##                              files group lib.size norm.factors lane
## 10_6_5_11 GSM1545535_10_6_5_11.txt    LP 32857304    0.8943956 L004
## 9_6_5_11   GSM1545536_9_6_5_11.txt    ML 35328624    1.0250186 L004
## purep53     GSM1545538_purep53.txt Basal 57147943    1.0459005 L004
## JMS8-2       GSM1545539_JMS8-2.txt Basal 51356800    1.0458455 L006
## JMS8-3       GSM1545540_JMS8-3.txt    ML 75782871    1.0162707 L006
## JMS8-4       GSM1545541_JMS8-4.txt    LP 60506774    0.9217132 L006
## JMS8-5       GSM1545542_JMS8-5.txt Basal 55073018    0.9961959 L006
## JMS9-P7c   GSM1545544_JMS9-P7c.txt    ML 21305254    1.0861026 L008
## JMS9-P8c   GSM1545545_JMS9-P8c.txt    LP 19955335    0.9839203 L008
```

We will manually take the mean across basal samples and LP samples.


```r
# Collect the counts
raw_counts <- dge$counts
# Basal samples are columns 3, 4, and 7
basal_sample_means <- rowMeans2(raw_counts[, c(3, 4, 7)])
# LP samples are columns 1, 6, and 9
LP_sample_means <- rowMeans2(raw_counts[, c(1, 6, 9)])
```

Then we will plot the two groups.


```r
plot(basal_sample_means, LP_sample_means)
```

<img src="04-FC_MAplots_files/figure-html/unnamed-chunk-6-1.png" width="672" />

This is hard to interpret. Most of the genes are clustered in the bottom left corner.

## Transforming ($\log_{2}$)

Using a $\log_{2}$ transformation makes it easier to examine all the genes together.


```r
# Plot with log2 transformation
plot(log2(basal_sample_means), log2(LP_sample_means))
```

<img src="04-FC_MAplots_files/figure-html/unnamed-chunk-7-1.png" width="672" />

## Using Fold-Change

As stated at the very start of this chapter, plotting differences versus means can be very helpful when many genes are correlated. It also makes interpretation easier when combined with a $\log_{2}$ transformation. 

When basal and LP expression are equal, fold-change is equal to zero.


```r
log2(10) - log2(10)
```

```
## [1] 0
```

When basal expression is greater, fold-change is positive.


```r
log2(20) - log2(10)
```

```
## [1] 1
```

```r
log2(100) - log2(1)
```

```
## [1] 6.643856
```

However when LP expression is greater, fold-change is negative.


```r
log2(10) - log2(20)
```

```
## [1] -1
```

```r
log2(1) - log2(100)
```

```
## [1] -6.643856
```

Calculate fold-change for the data.


```r
log2_fold_change <- log2(basal_sample_means) - log2(LP_sample_means)
mean_expression <- (log2(basal_sample_means) + log2(LP_sample_means)) / 2
```

Plot the values above, with mean expression on the x-axis and fold-change on the y-axis.


```r
plot(mean_expression, log2_fold_change)
```

<img src="04-FC_MAplots_files/figure-html/unnamed-chunk-12-1.png" width="672" />

This gives us a very rough idea of how transformation and using fold-change can aid in interpretation of the data. In reality, we need to cover a few more steps before creating this kind of plot.

## About MA Plots

In the previous steps, you created a preliminary MA plot. MA plots are a widely used way to visualize genomic data. As you experienced above, these plots are a specific type of scatterplot typically used for gene expression datasets. The _**M**_ represents the difference between two conditions (fold-change), while the _**A**_ represents the average intensity of the expression. Both values take on a $\log_{2}$ transformation.

_**M**_ is expressed as a log ratio or difference in the following form. _**M**_ is almost always placed on the y-axis.

$$M = log_{2}(\frac{condition 1}{condition 2}) = log_{2}(condition 1) - log_{2}(condition2)$$

_**A**_ is more simple, taking the form of a transformed average. _**A**_ is often called "log mean expression" and is almost always placed on the x-axis.

$$A = \frac{1}{2} (log_{2}(condition 1) + log_{2}(condition 2))$$
In the next steps, we will go over how to create an MA plot using `limma`. First, we will need to supply the design matrix and contrast matrix.

### The Design Matrix

Load the design matrix. This indicates which samples correspond to which cell populations.


```r
# Load the experimental design matrix
design <- readRDS(
  system.file("RNAseq123/design.rds", package = "Glimma"))
design
```

```
##   Basal LP ML laneL006 laneL008
## 1     0  1  0        0        0
## 2     0  0  1        0        0
## 3     1  0  0        0        0
## 4     1  0  0        1        0
## 5     0  0  1        1        0
## 6     0  1  0        1        0
## 7     1  0  0        1        0
## 8     0  0  1        0        1
## 9     0  1  0        0        1
## attr(,"assign")
## [1] 1 1 1 2 2
## attr(,"contrasts")
## attr(,"contrasts")$group
## [1] "contr.treatment"
## 
## attr(,"contrasts")$lane
## [1] "contr.treatment"
```

### The Contrast Matrix

Load the contrast matrix. This indicates which cell populations we want to compare.


```r
contr.matrix <- readRDS(
  system.file("RNAseq123/contr.matrix.rds", package = "Glimma"))
```

### Fitting the Data

There are several more steps to normalize and fit the data before making an MA plot. Don't worry! We will cover these steps in more detail later in the course. Briefly, the `voom()` function $\log_{2}$ transforms and normalizes the data. `lmFit()` fits a linear model for each gene to examine differential expression between the cell populations we want to compare.


```r
v <- voom(dge, design)
vfit <- lmFit(v, design)
vfit <- contrasts.fit(vfit, contrasts = contr.matrix)
```

## Creating an MA Plot

A simple MA plot can be produced with the `plotMA()` function. Other packages for exploring differential gene expression in R, such as `DESeq2`, also have functions to create MA plots.


```r
plotMA(vfit)
```

<img src="04-FC_MAplots_files/figure-html/unnamed-chunk-16-1.png" width="672" />

## Interactive MA Plots

`glimmaMA()` from the `Glimma` package creates interactive MA plots. Again, don't worry about the preparation steps - these will be covered in more detail later. `eBayes()` computes statistics by empirical Bayes moderation of the standard errors towards a global value.


```r
efit <- eBayes(vfit)
glimmaMA(efit, dge = dge)
```

<!--html_preserve--><div id="htmlwidget-2513cb4b2fe08ff847a0" style="width:920px;height:920px;" class="glimmaXY html-widget"></div>

## Recap


```r
sessionInfo()
```

```
## R version 4.0.2 (2020-06-22)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 20.04.3 LTS
## 
## Matrix products: default
## BLAS/LAPACK: /usr/lib/x86_64-linux-gnu/openblas-pthread/libopenblasp-r0.3.8.so
## 
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=C             
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                 
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
## [1] matrixStats_0.61.0 limma_3.46.0       Glimma_2.0.0      
## 
## loaded via a namespace (and not attached):
##  [1] MatrixGenerics_1.2.1        Biobase_2.50.0             
##  [3] httr_1.4.2                  edgeR_3.32.1               
##  [5] jsonlite_1.7.1              bit64_4.0.5                
##  [7] splines_4.0.2               highr_0.8                  
##  [9] BiocManager_1.30.10         stats4_4.0.2               
## [11] blob_1.2.1                  GenomeInfoDbData_1.2.4     
## [13] yaml_2.2.1                  pillar_1.4.6               
## [15] RSQLite_2.2.1               lattice_0.20-41            
## [17] glue_1.6.1                  digest_0.6.25              
## [19] GenomicRanges_1.42.0        RColorBrewer_1.1-2         
## [21] XVector_0.30.0              colorspace_1.4-1           
## [23] htmltools_0.5.0             Matrix_1.2-18              
## [25] DESeq2_1.30.1               XML_3.99-0.5               
## [27] pkgconfig_2.0.3             genefilter_1.72.1          
## [29] bookdown_0.24               zlibbioc_1.36.0            
## [31] purrr_0.3.4                 xtable_1.8-4               
## [33] scales_1.1.1                BiocParallel_1.24.1        
## [35] tibble_3.0.3                annotate_1.68.0            
## [37] generics_0.0.2              IRanges_2.24.1             
## [39] ggplot2_3.3.2               ellipsis_0.3.1             
## [41] SummarizedExperiment_1.20.0 BiocGenerics_0.36.1        
## [43] survival_3.1-12             magrittr_2.0.2             
## [45] crayon_1.3.4                memoise_1.1.0              
## [47] evaluate_0.14               tools_4.0.2                
## [49] lifecycle_1.0.0             stringr_1.4.0              
## [51] S4Vectors_0.28.1            munsell_0.5.0              
## [53] locfit_1.5-9.4              DelayedArray_0.16.3        
## [55] AnnotationDbi_1.52.0        compiler_4.0.2             
## [57] jquerylib_0.1.4             GenomeInfoDb_1.26.7        
## [59] rlang_0.4.10                grid_4.0.2                 
## [61] RCurl_1.98-1.2              htmlwidgets_1.5.2          
## [63] bitops_1.0-7                rmarkdown_2.10             
## [65] gtable_0.3.0                DBI_1.1.0                  
## [67] R6_2.4.1                    knitr_1.33                 
## [69] dplyr_1.0.2                 bit_4.0.4                  
## [71] stringi_1.5.3               parallel_4.0.2             
## [73] Rcpp_1.0.8                  vctrs_0.3.4                
## [75] geneplotter_1.68.0          tidyselect_1.1.0           
## [77] xfun_0.26
```