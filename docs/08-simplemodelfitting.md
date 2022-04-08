# (PART\*) PUTTING IT TOGETHER {-}

# Simple Model Fitting



## Overview

Now that we are familiar with [`SummarizedExperiment`](summarizedexperiment.html#summarizedexperiment) and [design matrices](design-matrices.html#design-matrices), we can apply what we learned to the `airway` dataset. 

Recall that the "airway" data is from an RNA-Seq experiment on four human airway smooth muscle cell lines treated with dexamethasone. You can learn more about the experiment in @Himes2014. 

## Load & Prepare Data

Load the `airway` dataset. You might need to install it.


```r
# AnVIL::install("airway")
library(airway)
data(airway)
```

You should also save the assay data from `airway`. Remember that this contains the gene counts.


```r
assay_data <- assay(airway)
```

## Creating the Design Matrix

You should create a design matrix like you did in the [previous chapter](design-matrices.html#inpractice). Since this is a categorical variable, we need to use a [means](#means) or [mean-reference](#meanref) model. We will use a mean-reference model because we are interested in the difference attributable to the treatment.


```r
sample_data <- colData(airway)
design_matrix <- model.matrix( ~ sample_data$dex)
```

## Testing with `lmFit` and `eBayes`.

Now we start the exciting process of model fitting! You will need the `limma` package.


```r
# AnVIL::install("limma")
library(limma)
```

First, we want to transform the count data before we proceed. The `voom()` function transforms count data to $\log_{2}$-counts per million (logCPM), estimates the mean-variance relationship, and uses this to compute appropriate observation-level weights. We should also supply the design matrix.


```r
assay_data <- voom(assay_data, design = design_matrix)
```

Next, use the `limma` function `lmFit()`. This function fits multiple linear models by weighted or generalized least squares. A linear model is fitted to the expression data for each gene. We should also supply the design matrix.


```r
fit <- lmFit(assay_data, design = design_matrix)
```

The code above estimates coefficients, but it's easier to interpret if we have log-odd or p-values. We can use `eBayes()` for this. This function computes moderated t-statistics, moderated F-statistic, and log-odds of differential expression by empirical Bayes moderation of the standard errors, given the output of `lmFit()`. This allows us to rank genes in order of evidence for differential expression. Using empirical Bayes methods squeezes the gene-wise residual variances toward a common value (or towards a global trend).


```r
fit <- eBayes(fit)
```

Now that we have a fitted model and estimated statistics, we can select the top-ranked genes for for the design matrix we supplied (remember, we are looking at the effect of dexamethasone treatment). 


```r
topTable(fit)
```

```
## Removing intercept from test coefficients
```

```
##                     logFC  AveExpr         t      P.Value    adj.P.Val
## ENSG00000134686 -1.304196 6.837469 -22.28727 1.384466e-09 8.874707e-05
## ENSG00000148175 -1.364975 8.854588 -18.96349 6.315648e-09 1.428428e-04
## ENSG00000162614 -1.945885 7.636408 -17.51779 1.325278e-08 1.428428e-04
## ENSG00000162616 -1.430717 5.903480 -17.27478 1.509630e-08 1.428428e-04
## ENSG00000189221 -3.263290 5.949117 -16.91641 1.835153e-08 1.428428e-04
## ENSG00000152583 -4.480843 4.165462 -17.88614 1.091355e-08 1.428428e-04
## ENSG00000120129 -2.847874 6.643013 -16.56703 2.228368e-08 1.428428e-04
## ENSG00000178695  2.589942 6.450283  16.57994 2.212289e-08 1.428428e-04
## ENSG00000196517  2.289351 3.024889  17.85198 1.111011e-08 1.428428e-04
## ENSG00000125148 -2.136635 7.022630 -15.98043 3.114408e-08 1.814907e-04
##                         B
## ENSG00000134686 12.547426
## ENSG00000148175 11.263744
## ENSG00000162614 10.516600
## ENSG00000162616 10.307478
## ENSG00000189221 10.103458
## ENSG00000152583 10.049829
## ENSG00000120129  9.977213
## ENSG00000178695  9.974713
## ENSG00000196517  9.831402
## ENSG00000125148  9.673848
```

## Interpreting `topTable()` Output

You now have the top genes affected by the treatment. Here's how we can interpret the output.

- **logFC**: estimate of the log2-fold-change corresponding to the effect of the treatment. Negative values mean the second treatment, in this case `untrt`, has lower expression than the baseline, in this case `trt`. Take a look at the design matrix to confirm.

- **AveExpr	**: average log2-expression for the gene over all samples.

- **t**: moderated t-statistic

- **P.Value**: raw p-value

- **adj.P.Value**: adjusted p-value using the Benjamini & Hochberg method (by default)

- **B**: log-odds that the gene is differentially expressed

::: {.fyi}
QUESTIONS:

1. The top three genes have a negative logFC. Which treatment (`untrt` or `trt`) had greater expression?
2. `eBayes()` performs p-value adjustment automatically. Why is it essential that we perform p-value adjustment for gene expression data?
:::

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
## [1] parallel  stats4    stats     graphics  grDevices utils     datasets 
## [8] methods   base     
## 
## other attached packages:
##  [1] limma_3.46.0                airway_1.10.0              
##  [3] SummarizedExperiment_1.20.0 Biobase_2.50.0             
##  [5] GenomicRanges_1.42.0        GenomeInfoDb_1.26.7        
##  [7] IRanges_2.24.1              S4Vectors_0.28.1           
##  [9] BiocGenerics_0.36.1         MatrixGenerics_1.2.1       
## [11] matrixStats_0.61.0         
## 
## loaded via a namespace (and not attached):
##  [1] XVector_0.30.0         knitr_1.33             magrittr_2.0.2        
##  [4] zlibbioc_1.36.0        lattice_0.20-41        rlang_0.4.10          
##  [7] stringr_1.4.0          tools_4.0.2            grid_4.0.2            
## [10] xfun_0.26              jquerylib_0.1.4        htmltools_0.5.0       
## [13] yaml_2.2.1             digest_0.6.25          bookdown_0.24         
## [16] Matrix_1.2-18          GenomeInfoDbData_1.2.4 BiocManager_1.30.10   
## [19] bitops_1.0-7           RCurl_1.98-1.2         evaluate_0.14         
## [22] rmarkdown_2.10         DelayedArray_0.16.3    stringi_1.5.3         
## [25] compiler_4.0.2
```
