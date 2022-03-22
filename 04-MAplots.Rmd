# (PART\*) DIFFERENTIAL EXPRESSION {-}

# MA Plots

## Overview {#MA-overview}

This chapter explains how to create your own MA plots.

MA plots are a way to visualize genomic data. These plots are a specific type of scatterplot typically used for gene expression datasets. The _**M**_ represents the difference between two conditions, while the _**A**_ represents the average intensity of the expression. Both values take on a $\log_{2}$ transformation.

_**M**_ is expressed as a log ratio in the following form. _**M**_ is often called "log fold change" and is almost always placed on the y-axis.

$$M = log_{2}(\frac{condition 1}{condition 2})$$

_**A**_ is more simple, taking the form of a transformed average. _**A**_ is often called "log mean expression" and is almost always placed on the x-axis.

$$M = \frac{1}{2} (log_{2}(condition 1) + log_{2}(condition 2))$$
