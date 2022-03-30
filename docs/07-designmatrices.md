# Design Matrices

## Overview

When performing differential expression analysis on genomic data (such as RNA-seq experiments), scientists usually use linear models to determine the direction (did expression go up or down?) and magnitude (by how much?) of the change in expression. These scientists are interested in understanding the relationship between gene expression (the "response" variable") and variables that affect expression, such as a treatment or cell type ("explanatory variable(s)").

Design matrices are fundamental concepts in mathematics, statistics, and other domains, but their application to genomic data can introduce some complexity.

See this Bioconductor [vignette](https://bioconductor.org/packages/release/workflows/vignettes/RNAseq123/inst/doc/designmatrices.html#introduction) for an excellent, in-depth look at design matrices.

## Types of Models

The type of explanatory variables in our experiment will determine what our model looks like. 

### Regression: Continuous Variables

Continuous variables, or covariates, are numeric. This means that we could create a scatterplot comparing the covariate and expression. We could then imagine drawing a best fit line through those points to create our model. @Law2020 state:

> [Covariates] can be the age or weight of an individual, or other molecular or cellular phenotypes on a sample... For covariates, it is generally of interest to know the rate of change between the response and the covariate, such as “how much does the expression of a particular gene increase/decrease per unit increase in age?”. We can use a straight line to model, or describe, this relationship, which takes the form of 
> 
> $$Expression = \beta_{0} + \beta_{1}age$$
>
> where the line is defined by $\beta_{0}$ the y-intercept and $\beta_{1}$ the slope. In this model, the age covariate takes continuous, numerical values such as 0.8, 1.3, 2.0, 5.6, and so on.

These $\beta$ values are known as _parameters_ and are important for determining the impact of explanatory variables on expression.

<img src="07-designmatrices_files/figure-html//1BLTCaogA04bbeSD1tR1Wt-mVceQA6FHXa8FmFzIARrg_g1204ed6db6a_1_29.png" title="Image of expression plotted against age with a regression fit line added. The caption reads, the basic model for covariates is referred to as a regression model, which is a line defined by the model parameters beta-0 the y-intercept, and beta-1 the slope. The points represent the original data; coloured lines are used to represent expected gene expression." alt="Image of expression plotted against age with a regression fit line added. The caption reads, the basic model for covariates is referred to as a regression model, which is a line defined by the model parameters beta-0 the y-intercept, and beta-1 the slope. The points represent the original data; coloured lines are used to represent expected gene expression." width="480" />

### Means: Categorical Variables

Categorical variables are discrete variables, or factors. We can think of these variables as "bins" that our samples fall into. @Law2020 state:

> [Factors] are often separated into those that are of a biological nature (e.g. disease status, genotype, treatment, cell-type) and those that are of a technical nature (e.g. experiment time, sample batch, handling technician, sequencing lane). Unique values within a factor are referred to as levels. For example, genotype as a factor may contain two levels, “wildtype” and “mutant”. Here, it is generally of interest to determine the expected or mean gene expression for each state or level of the factor. The relationship between gene expression and the factor can be described, or modeled, in the form of 
>
> $$Expression = \beta_{1}wildtype + \beta_{2}mutant$$
>
> where $\beta_{1}$ represents the mean gene expression for wildtype, and $\beta_{2}$ represents the mean gene expression for mutant.

The "genotype" factor in this model is not numeric like "age" above, so the calculations work a bit differently. For any given sample, it can be either wildtype or mutant but not both. So, the values "wildtype" and "mutant" can only be zero (no) or one (yes). When a sample is mutant, "wildtype" = 0, and $\beta_{1}$ drops out of the equation. Likewise, when a sample is wildtype, "mutant" = 0, and $\beta_{2}$ drops out of the equation. This kind of model is called a **means model**.

<img src="07-designmatrices_files/figure-html//1BLTCaogA04bbeSD1tR1Wt-mVceQA6FHXa8FmFzIARrg_g1204ed6db6a_1_56.png" title="Image of expression plotted against age with lines fitted for each category. The caption reads, One of two basic models for factors is referred to as a means model, where model parameters are calculated as the mean gene expression of each level of the factor e.g. beta-1 represents the mean expression for wildtype and beta-2 represents the mean of mutant. The points represent the original data; coloured lines are used to represent expected gene expression." alt="Image of expression plotted against age with lines fitted for each category. The caption reads, One of two basic models for factors is referred to as a means model, where model parameters are calculated as the mean gene expression of each level of the factor e.g. beta-1 represents the mean expression for wildtype and beta-2 represents the mean of mutant. The points represent the original data; coloured lines are used to represent expected gene expression." width="480" />

### Mean-Reference: Categorical Variables

You can also design categorical models with a "reference" value for comparison. @Law2020 state:

> An alternative parameterisation of the means model directly calculates the gene expression difference between mutant and wildtype. It does so by using one of the levels as a reference. Such a model is parameterised for the mean expression of the reference level (e.g. wildtype), and the rest of the levels are parameterised relative to the reference (e.g. the difference between mutant and wildtype). The relationship between gene expression and genotype is modeled in the form of 
>
> $$Expression = \beta_{1} + \beta_{2}mutant$$
>
> where $\beta_{1}$ represents the mean gene expression for wildtype, and $\beta_{2}$ is the difference between means of mutant and wildtype

This kind of model can be really useful if you are interested in the _**difference**_ between groups rather than the estimated parameters for the groups themselves. This kind of model is called a **mean-reference model**.

<img src="07-designmatrices_files/figure-html//1BLTCaogA04bbeSD1tR1Wt-mVceQA6FHXa8FmFzIARrg_g1204ed6db6a_1_67.png" title="Image of expression plotted against age with lines fitted for each category. The other basic model we refer to for factors is a mean-reference model, where the first model parameter is calculated as the mean gene expression of the reference level, and subsequent parameters are calculated relative to the reference level e.g. beta-1 represents the mean expression for wildtype and beta-2 represents the difference between mutant and wildtype. The points represent the original data; coloured lines are used to represent expected gene expression. where dashed lines are specifically used to represent expected gene expression for non-reference levels in the mean-reference model e.g. mutant." alt="Image of expression plotted against age with lines fitted for each category. The other basic model we refer to for factors is a mean-reference model, where the first model parameter is calculated as the mean gene expression of the reference level, and subsequent parameters are calculated relative to the reference level e.g. beta-1 represents the mean expression for wildtype and beta-2 represents the difference between mutant and wildtype. The points represent the original data; coloured lines are used to represent expected gene expression. where dashed lines are specifically used to represent expected gene expression for non-reference levels in the mean-reference model e.g. mutant." width="480" />

## Making a Design Matrix

@Law2020 use the following data to demonstrate how you might build a design matrix. This is a very simple example - in reality, we'd have many more genes being expressed.




```r
df
```

```
##   expression  mouse age   group
## 1       2.38 MOUSE1   1 HEALTHY
## 2       2.85 MOUSE2   2 HEALTHY
## 3       3.60 MOUSE3   3 HEALTHY
## 4       4.06 MOUSE4   4    SICK
## 5       4.61 MOUSE5   5    SICK
## 6       5.04 MOUSE6   6    SICK
```

### Regression: Continuous Variables

Use the `model.matrix()` function to create the design matrix with the continuous variable "age".


```r
model.matrix( ~ df$age)
```

```
##   (Intercept) df$age
## 1           1      1
## 2           1      2
## 3           1      3
## 4           1      4
## 5           1      5
## 6           1      6
## attr(,"assign")
## [1] 0 1
```


```
## Installing package into '/usr/local/lib/R/site-library'
## (as 'lib' is unspecified)
```

<img src="07-designmatrices_files/figure-html/unnamed-chunk-7-1.png" width="672" />

You can remove the intercept by adding zero to the design matrix. This forces the y-intercept to be zero. You could also use a different number here.


```r
model.matrix( ~ 0 + df$age)
```

```
##   df$age
## 1      1
## 2      2
## 3      3
## 4      4
## 5      5
## 6      6
## attr(,"assign")
## [1] 1
```

<img src="07-designmatrices_files/figure-html/unnamed-chunk-9-1.png" width="672" />

### Means: Categorical Variables

Use the `model.matrix()` function to create the design matrix with the factor "group". To create a **means model**, you should include a zero in the model.


```r
model.matrix( ~ 0 + df$group)
```

```
##   df$groupHEALTHY df$groupSICK
## 1               1            0
## 2               1            0
## 3               1            0
## 4               0            1
## 5               0            1
## 6               0            1
## attr(,"assign")
## [1] 1 1
## attr(,"contrasts")
## attr(,"contrasts")$`df$group`
## [1] "contr.treatment"
```

<img src="07-designmatrices_files/figure-html/unnamed-chunk-11-1.png" width="672" />

Notice that you only see zeros and ones for the two groups: `df$groupHEALTHY` and `df$groupSICK`.

### Mean-Reference: Categorical Variables

Simply remove the zero to use a **mean-reference model**.


```r
model.matrix( ~ df$group)
```

```
##   (Intercept) df$groupSICK
## 1           1            0
## 2           1            0
## 3           1            0
## 4           1            1
## 5           1            1
## 6           1            1
## attr(,"assign")
## [1] 0 1
## attr(,"contrasts")
## attr(,"contrasts")$`df$group`
## [1] "contr.treatment"
```

<img src="07-designmatrices_files/figure-html/unnamed-chunk-13-1.png" width="672" />

Notice how there is now an intercept. Remember that the parameter will now represent the _**difference**_ between the groups instead of the second group mean.

## More Complex Designs

`model.matrix()` can easily handle more complex experimental designs.




```r
df2
```

```
##    expression   mouse   group     type
## 1        2.38  MOUSE1 HEALTHY WILDTYPE
## 2        2.85  MOUSE2 HEALTHY WILDTYPE
## 3        3.60  MOUSE3 HEALTHY WILDTYPE
## 4        4.06  MOUSE4    SICK WILDTYPE
## 5        4.61  MOUSE5    SICK WILDTYPE
## 6        5.04  MOUSE6    SICK WILDTYPE
## 7        6.48  MOUSE7 HEALTHY   MUTANT
## 8        6.70  MOUSE8 HEALTHY   MUTANT
## 9        8.01  MOUSE9 HEALTHY   MUTANT
## 10      11.99 MOUSE10    SICK   MUTANT
## 11      12.81 MOUSE11    SICK   MUTANT
## 12      14.73 MOUSE12    SICK   MUTANT
```

The following will create a design matrix for "group" and "type".


```r
model.matrix( ~ df2$group + df2$type)
```

```
##    (Intercept) df2$groupSICK df2$typeWILDTYPE
## 1            1             0                1
## 2            1             0                1
## 3            1             0                1
## 4            1             1                1
## 5            1             1                1
## 6            1             1                1
## 7            1             0                0
## 8            1             0                0
## 9            1             0                0
## 10           1             1                0
## 11           1             1                0
## 12           1             1                0
## attr(,"assign")
## [1] 0 1 2
## attr(,"contrasts")
## attr(,"contrasts")$`df2$group`
## [1] "contr.treatment"
## 
## attr(,"contrasts")$`df2$type`
## [1] "contr.treatment"
```

Use the "*" to create a design matrix for the "group" and "type" as well as their interaction.


```r
model.matrix( ~ df2$group + df2$type)
```

```
##    (Intercept) df2$groupSICK df2$typeWILDTYPE
## 1            1             0                1
## 2            1             0                1
## 3            1             0                1
## 4            1             1                1
## 5            1             1                1
## 6            1             1                1
## 7            1             0                0
## 8            1             0                0
## 9            1             0                0
## 10           1             1                0
## 11           1             1                0
## 12           1             1                0
## attr(,"assign")
## [1] 0 1 2
## attr(,"contrasts")
## attr(,"contrasts")$`df2$group`
## [1] "contr.treatment"
## 
## attr(,"contrasts")$`df2$type`
## [1] "contr.treatment"
```

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
## [1] ggplot2_3.3.2
## 
## loaded via a namespace (and not attached):
##  [1] pillar_1.4.6     compiler_4.0.2   jquerylib_0.1.4  highr_0.8       
##  [5] tools_4.0.2      digest_0.6.25    lattice_0.20-41  nlme_3.1-148    
##  [9] evaluate_0.14    lifecycle_1.0.0  tibble_3.0.3     gtable_0.3.0    
## [13] mgcv_1.8-31      pkgconfig_2.0.3  png_0.1-7        rlang_0.4.10    
## [17] Matrix_1.2-18    curl_4.3         yaml_2.2.1       xfun_0.26       
## [21] withr_2.3.0      httr_1.4.2       stringr_1.4.0    dplyr_1.0.2     
## [25] knitr_1.33       generics_0.0.2   fs_1.5.0         vctrs_0.3.4     
## [29] hms_0.5.3        grid_4.0.2       tidyselect_1.1.0 glue_1.6.1      
## [33] R6_2.4.1         ottrpal_0.1.2    rmarkdown_2.10   bookdown_0.24   
## [37] farver_2.0.3     readr_1.4.0      purrr_0.3.4      magrittr_2.0.2  
## [41] splines_4.0.2    scales_1.1.1     ellipsis_0.3.1   htmltools_0.5.0 
## [45] colorspace_1.4-1 labeling_0.3     stringi_1.5.3    munsell_0.5.0   
## [49] crayon_1.3.4
```
