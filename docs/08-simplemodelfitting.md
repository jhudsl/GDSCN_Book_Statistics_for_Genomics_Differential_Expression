# (PART\*) PUTTING IT TOGETHER {-}

# Simple Model Fitting

## Overview

Now that you are familiar with [`SummarizedExperiment`](summarizedexperiment.html#summarizedexperiment) and [design matrices](design-matrices.html#design-matrices), you can apply what you learned to the `airway` dataset. 

Recall that the `airway` data is from an RNA-Seq experiment on four human airway smooth muscle cell lines treated with dexamethasone. You can learn more about the experiment in @Himes2014. 

## Load & Prepare Data

Load the `airway` dataset. You might need to install it.


```r
# AnVIL::install("airway")
library(airway)
data(airway)
```

You should also save the assay data from `airway`. Remember that `assay()` extracts the gene counts.


```r
assay_data <- assay(airway)
```

## Creating the Design Matrix

You should create a design matrix like you did in the [previous chapter](design-matrices.html#inpractice). 

Since the dexamethasone treatment is a categorical variable, you need to use a [means](#means) or [mean-reference](#meanref) model. Going forward, we will use a mean-reference model because we are interested in the difference attributable to the treatment.


```r
sample_data <- colData(airway)
design_matrix <- model.matrix( ~ sample_data$dex)
```

## Testing with `lmFit` and `eBayes`

Now you start the exciting process of model fitting! You will need the `limma` package.


```r
# AnVIL::install("limma")
library(limma)
```

You want to transform the count data before proceeding with model fitting. 

The `voom()` function transforms count data to $\log_{2}$-counts per million (logCPM), estimates the mean-variance relationship, and uses these values to compute appropriate observation-level weights. This is an important step that takes into account the mean-variance relationship in the data. In other words, it factors in that as gene counts (expression) becomes greater, so does the variance. `voom()` also corrects for differences in sequencing depth among samples (libraries). This can happen when one sample starts with more total RNA or the sequencer produces more data for one sample over another.

You should also supply the design matrix.


```r
assay_data <- voom(assay_data, design = design_matrix)
```

Next, use the `limma` function `lmFit()`. This function fits multiple linear models by weighted or generalized least squares. A linear model is fitted to the expression data for each gene. As above, you should supply the design matrix.


```r
fit <- lmFit(assay_data, design = design_matrix)
```

The code above estimates coefficients, but it's easier to interpret if you have log-odd or p-values. You can use `eBayes()` for this. 

The `eBayes()` function computes moderated t-statistics, moderated F-statistic, and log-odds of differential expression by empirical Bayes moderation of the standard errors, when this function is given the output of `lmFit()`. This allows us to rank genes in order of evidence for differential expression. Using empirical Bayes methods squeezes the gene-wise residual variances toward a common value (or towards a global trend).


```r
fit <- eBayes(fit)
```

Now that you have a fitted model and estimated statistics, you can look at individual genes. 

Because the fitted models are based on the design matrix we supplied, "top" genes will be based the difference between `trt` and `untrt`. Remember that these indicate whether or not cells received dexamethasone treatment. The function `topTable()` shows you the top-ranked genes given the model you supplied.


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

You now have the top genes affected by the treatment. Here's how you can interpret the output.

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
## R version 4.1.3 (2022-03-10)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 20.04.4 LTS
## 
## Matrix products: default
## BLAS:   /usr/lib/x86_64-linux-gnu/openblas-pthread/libblas.so.3
## LAPACK: /usr/lib/x86_64-linux-gnu/openblas-pthread/liblapack.so.3
## 
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8   
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                 
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       
## 
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods  
## [8] base     
## 
## other attached packages:
##  [1] limma_3.50.3                airway_1.14.0              
##  [3] SummarizedExperiment_1.24.0 Biobase_2.54.0             
##  [5] GenomicRanges_1.46.1        GenomeInfoDb_1.30.1        
##  [7] IRanges_2.28.0              S4Vectors_0.32.4           
##  [9] BiocGenerics_0.40.0         MatrixGenerics_1.6.0       
## [11] matrixStats_0.61.0         
## 
## loaded via a namespace (and not attached):
##  [1] bslib_0.3.1            compiler_4.1.3         jquerylib_0.1.4       
##  [4] XVector_0.34.0         bitops_1.0-7           tools_4.1.3           
##  [7] zlibbioc_1.40.0        digest_0.6.29          jsonlite_1.8.0        
## [10] evaluate_0.15          lattice_0.20-45        rlang_1.0.2           
## [13] Matrix_1.4-0           DelayedArray_0.20.0    cli_3.2.0             
## [16] yaml_2.3.5             xfun_0.26              fastmap_1.1.0         
## [19] GenomeInfoDbData_1.2.7 stringr_1.4.0          knitr_1.33            
## [22] sass_0.4.1             grid_4.1.3             R6_2.5.1              
## [25] rmarkdown_2.10         bookdown_0.24          magrittr_2.0.3        
## [28] htmltools_0.5.2        stringi_1.7.6          RCurl_1.98-1.6
```
