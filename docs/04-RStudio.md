

# Working in RStudio {#rstudio}

Now that you have [created a Workspace](creating-a-workspace.html#workspace), you can create an RStudio cloud environment. This will allow you to interface with data and perform genomics-based analyses with add on packages from the Bioconductor community.

## Launch RStudio Cloud Environment

1. Click on the name of the Workspace you just created. You should be routed to a link that looks like: `https://anvil.terra.bio/#workspaces/<billing-project>/<workspace-name>`.

1. On the top right, Click the gear icon to access your Cloud Environment options.

    <img src="resources/images/04-RStudio_files/figure-html//1eypYLLqD11-NwHLs4adGpcuSB07dYEJfAaALSMvgzqw_gdde5ec9a4d_1_34.png" title="Screenshot of the newly created Workspace. The gear icon to create a new cloud environment is highlighted." alt="Screenshot of the newly created Workspace. The gear icon to create a new cloud environment is highlighted." width="480" />

1. You will see a list of costs because it costs a small amount of money to use cloud computing. Click "CUSTOMIZE".

    <img src="resources/images/04-RStudio_files/figure-html//1eypYLLqD11-NwHLs4adGpcuSB07dYEJfAaALSMvgzqw_gdde5ec9a4d_1_50.png" title="Screenshot of the cloud environment popout menu. The &quot;Customize&quot; button is highlighted." alt="Screenshot of the cloud environment popout menu. The &quot;Customize&quot; button is highlighted." width="480" />

1. Click on the first drop down menu to see what other software configurations are available.

    <img src="resources/images/04-RStudio_files/figure-html//1eypYLLqD11-NwHLs4adGpcuSB07dYEJfAaALSMvgzqw_gdde5ec9a4d_1_11.png" title="Screenshot of the cloud environment popout menu. The first dropdown menu for options, the Application configuration menu, is highlighted." alt="Screenshot of the cloud environment popout menu. The first dropdown menu for options, the Application configuration menu, is highlighted." width="480" />

1. Scroll down and select RStudio from the Community-Maintained RStudio Environments section. **NOTE**: AnVIL is very versatile and can scale up to use very powerful cloud computers. It's very important that you select the cloud computing environment described here to avoid runaway costs.

    <img src="resources/images/04-RStudio_files/figure-html//1eypYLLqD11-NwHLs4adGpcuSB07dYEJfAaALSMvgzqw_ge08067d6e2_0_0.png" title="Screenshot of the Application configuration menu. The community maintained RStudio environment is highlighted." alt="Screenshot of the Application configuration menu. The community maintained RStudio environment is highlighted." width="480" />

1. Leave everything else as-is. To create your RStudio Cloud Environment, click on the “CREATE” button.

    <img src="resources/images/04-RStudio_files/figure-html//1eypYLLqD11-NwHLs4adGpcuSB07dYEJfAaALSMvgzqw_ge08067d6e2_0_34.png" title="Screenshot of the Application configuration menu. The &quot;Create&quot; button is highlighted." alt="Screenshot of the Application configuration menu. The &quot;Create&quot; button is highlighted." width="480" />

1. Your Cloud Environment will be available in a few minutes after the cloud resources are provisioned and your software starts up. The upper right corner displays the status and should say “Creating” while resources are being provisioned.

    <img src="resources/images/04-RStudio_files/figure-html//1eypYLLqD11-NwHLs4adGpcuSB07dYEJfAaALSMvgzqw_ge08067d6e2_0_6.png" title="Screenshot of the Workspace page. A cloud environment for RStudio is being created. The loading icon on the top right of the page is highlighted." alt="Screenshot of the Workspace page. A cloud environment for RStudio is being created. The loading icon on the top right of the page is highlighted." width="480" />

1. After a few minutes, you will see the status change to “Running”.

    <img src="resources/images/04-RStudio_files/figure-html//1eypYLLqD11-NwHLs4adGpcuSB07dYEJfAaALSMvgzqw_ge08067d6e2_0_10.png" title="Screenshot of the Workspace page. A cloud environment for RStudio has been created. The icon on the top right showing that the cloud environment is running is highlighted." alt="Screenshot of the Workspace page. A cloud environment for RStudio has been created. The icon on the top right showing that the cloud environment is running is highlighted." width="480" />

1. Click on the “R” icon to launch RStudio.

    <img src="resources/images/04-RStudio_files/figure-html//1eypYLLqD11-NwHLs4adGpcuSB07dYEJfAaALSMvgzqw_ge08067d6e2_0_43.png" title="Screenshot of the Workspace page. A cloud environment for RStudio has been created. The R button that launches the RStudio interface is highlighted." alt="Screenshot of the Workspace page. A cloud environment for RStudio has been created. The R button that launches the RStudio interface is highlighted." width="480" />

1. You should now see the RStudio interface with information about the version printed to the console.

    <img src="resources/images/04-RStudio_files/figure-html//1eypYLLqD11-NwHLs4adGpcuSB07dYEJfAaALSMvgzqw_ge08067d6e2_0_14.png" title="Screenshot of the RStudio environment interface." alt="Screenshot of the RStudio environment interface." width="480" />

## Tour RStudio

Next, we will be using RStudio and the package `Glimma` to create interactive plots. See [this vignette](https://bioconductor.org/packages/release/bioc/vignettes/Glimma/inst/doc/limma_edger.html) for more information.

1. The Bioconductor team has created a very useful package to programmatically interact with Terra and Google Cloud. Install the `AnVIL` package. It will make some steps easier as we go along.

    
    ```r
    BiocManager::install("AnVIL")
    ```

    <img src="resources/images/04-RStudio_files/figure-html//1BLTCaogA04bbeSD1tR1Wt-mVceQA6FHXa8FmFzIARrg_g11f12bc99af_0_49.png" title="Screenshot of the RStudio environment interface. Code has been typed in the console and is highlighted." alt="Screenshot of the RStudio environment interface. Code has been typed in the console and is highlighted." width="480" />

1. You can now quickly install precompiled binaries using the AnVIL package’s `install()` function. We will use it to install the `Glimma` package and the `airway` package. The `airway` package contains a `SummarizedExperiment` data class. This data describes an RNA-Seq experiment on four human airway smooth muscle cell lines treated with dexamethasone. We will learn more about SummarizedExperiments in [following chapters](the-summarizedexperiment-class.html#summarizedexperiment).

    
    ```r
    AnVIL::install(c("Glimma", "airway"))
    ```

    <img src="resources/images/04-RStudio_files/figure-html//1BLTCaogA04bbeSD1tR1Wt-mVceQA6FHXa8FmFzIARrg_g11f12bc99af_0_56.png" title="Screenshot of the RStudio environment interface. Code has been typed in the console and is highlighted." alt="Screenshot of the RStudio environment interface. Code has been typed in the console and is highlighted." width="480" />

1. Load the example data.

    
    ```r
    library(airway)
    data(airway)
    ```

    <img src="resources/images/04-RStudio_files/figure-html//1BLTCaogA04bbeSD1tR1Wt-mVceQA6FHXa8FmFzIARrg_g11f12bc99af_0_56.png" title="Screenshot of the RStudio environment interface. Code has been typed in the console and is highlighted." alt="Screenshot of the RStudio environment interface. Code has been typed in the console and is highlighted." width="480" />

1. The multidimensional scaling (MDS) plot is frequently used to explore differences in samples. When this data is MDS transformed, the first two dimensions explain the greatest variance between samples, and the amount of variance decreases monotonically with increasing dimension. The following code will launch a new window where you can interact with the MDS plot.

    
    ```r
    Glimma::glimmaMDS(assay(airway), group = colData(airway)$dex)
    ```

    <img src="resources/images/04-RStudio_files/figure-html//1BLTCaogA04bbeSD1tR1Wt-mVceQA6FHXa8FmFzIARrg_g11f12bc99af_0_70.png" title="Screenshot of the Glimma popout showing the data in an MDS plot. All data points are blue." alt="Screenshot of the Glimma popout showing the data in an MDS plot. All data points are blue." width="480" />

1. Change the `colour_by` setting to "groups" so you can easily distinguish between groups. In this data, the "group" is the treatment.

    <img src="resources/images/04-RStudio_files/figure-html//1BLTCaogA04bbeSD1tR1Wt-mVceQA6FHXa8FmFzIARrg_g11f12bc99af_0_77.png" title="Screenshot of the Glimma popout showing the data in an MDS plot. Data points are colored blue and orange by group. The colour by dropdown menu on the interactive plot is hightlighted." alt="Screenshot of the Glimma popout showing the data in an MDS plot. Data points are colored blue and orange by group. The colour by dropdown menu on the interactive plot is hightlighted." width="480" />

1. You can download the interactive html file by clicking on "Save As".

    <img src="resources/images/04-RStudio_files/figure-html//1BLTCaogA04bbeSD1tR1Wt-mVceQA6FHXa8FmFzIARrg_g1204ed6da7f_0_0.png" title="Screenshot of the Glimma popout showing the data in an MDS plot. The Save As menu is highlighted." alt="Screenshot of the Glimma popout showing the data in an MDS plot. The Save As menu is highlighted." width="480" />

1. You can also download plots and other files created directly in RStudio. To download the following plot, click on "Export" and save in your preferred format to the default directory. This saves the file in your cloud environment.

    
    ```r
    limma::plotMDS(airway)
    ```

    <img src="resources/images/04-RStudio_files/figure-html//1BLTCaogA04bbeSD1tR1Wt-mVceQA6FHXa8FmFzIARrg_g1204ed6da7f_0_12.png" title="Screenshot of the RStudio interface. A plot has been created. The Export menu has been highlighted." alt="Screenshot of the RStudio interface. A plot has been created. The Export menu has been highlighted." width="480" />

1. You should see the plot in the "Files" pane.

    <img src="resources/images/04-RStudio_files/figure-html//1BLTCaogA04bbeSD1tR1Wt-mVceQA6FHXa8FmFzIARrg_g1204ed6da7f_0_19.png" title="Screenshot of the RStudio interface. A plot has been created. The saved pdf file is now visible under the &quot;Files&quot; pane." alt="Screenshot of the RStudio interface. A plot has been created. The saved pdf file is now visible under the &quot;Files&quot; pane." width="480" />

1. Select this file and click "More" > "Export"

    <img src="resources/images/04-RStudio_files/figure-html//1BLTCaogA04bbeSD1tR1Wt-mVceQA6FHXa8FmFzIARrg_g1204ed6db6a_0_0.png" title="Screenshot of the RStudio interface. A plot has been created. The saved pdf file is now visible under the &quot;Files&quot; pane. The &quot;More&quot; and &quot;Export&quot; menus have been highlighted." alt="Screenshot of the RStudio interface. A plot has been created. The saved pdf file is now visible under the &quot;Files&quot; pane. The &quot;More&quot; and &quot;Export&quot; menus have been highlighted." width="480" />

1. Select "Download" to save the file to your local machine.

    <img src="resources/images/04-RStudio_files/figure-html//1BLTCaogA04bbeSD1tR1Wt-mVceQA6FHXa8FmFzIARrg_g1204ed6db6a_0_8.png" title="Screenshot of the RStudio interface. The popup to download the selected file has been highlighted," alt="Screenshot of the RStudio interface. The popup to download the selected file has been highlighted," width="480" />

## More Practice with `iSEE`

`iSEE` is a Bioconductor package that provides an interactive Shiny-based graphical user interface for exploring data stored in SummarizedExperiment objects [@RueAlbrecht2018]. Run the following.


```r
# Install iSEE
AnVIL::install("iSEE")

# Launch app on airway data
iSEE::iSEE(airway)
```

<img src="resources/images/04-RStudio_files/figure-html//1BLTCaogA04bbeSD1tR1Wt-mVceQA6FHXa8FmFzIARrg_g11f12bc99af_0_56.png" title="Screenshot of the RStudio environment interface. Code has been typed in the console and is highlighted." alt="Screenshot of the RStudio environment interface. Code has been typed in the console and is highlighted." width="480" />
    
The Shiny app will allow you to explore genes and samples.

<img src="resources/images/04-RStudio_files/figure-html//1BLTCaogA04bbeSD1tR1Wt-mVceQA6FHXa8FmFzIARrg_g1204ed6db6a_1_12.png" title="Screenshot of the iSEE popout. The gene related windows are shown." alt="Screenshot of the iSEE popout. The gene related windows are shown." width="480" />

<img src="resources/images/04-RStudio_files/figure-html//1BLTCaogA04bbeSD1tR1Wt-mVceQA6FHXa8FmFzIARrg_g1204ed6db6a_1_19.png" title="Screenshot of the iSEE popout. The sample related windows are shown." alt="Screenshot of the iSEE popout. The sample related windows are shown." width="480" />

## Pause RStudio {#stopping}

1. The upper right corner reminds you that you are accruing cloud computing costs.

    <img src="resources/images/04-RStudio_files/figure-html//1BLTCaogA04bbeSD1tR1Wt-mVceQA6FHXa8FmFzIARrg_g11f12bc99af_0_84.png" title="Screenshot of the RStudio interface. The icon on the top right showing that the cloud environment is running is highlighted." alt="Screenshot of the RStudio interface. The icon on the top right showing that the cloud environment is running is highlighted." width="480" />

1. You should minimize charges when you are not performing an analysis. You can do this by clicking on “Stop cloud environment”. This will release the CPU and memory resources for other people to use. Note that your work will be saved in the environment and continue to accrue a very small cost. Your instructor can delete these environments to stop costs accruing, so it's a good idea to save code or output somewhere else, such as GitHub or your local machine.

    <img src="resources/images/04-RStudio_files/figure-html//1BLTCaogA04bbeSD1tR1Wt-mVceQA6FHXa8FmFzIARrg_g11f12bc99af_0_91.png" title="Screenshot of the RStudio interface. The stop icon on the top right which stops the cloud environment is highlighted." alt="Screenshot of the RStudio interface. The stop icon on the top right which stops the cloud environment is highlighted." width="480" />

## Delete RStudio Cloud Environment

1. [Stopping](#stopping) your cloud environment only pauses your work. When you are ready to delete the cloud environment, click on the gear icon in the upper right corner to “Update cloud environment”.

    <img src="resources/images/04-RStudio_files/figure-html//1eypYLLqD11-NwHLs4adGpcuSB07dYEJfAaALSMvgzqw_ge1182913a6_0_41.png" title="Screenshot of the Workspace page. The gear icon on the top right that updates the cloud environment is highlighted." alt="Screenshot of the Workspace page. The gear icon on the top right that updates the cloud environment is highlighted." width="480" />

1. Click on “Delete Environment Options”.

    <img src="resources/images/04-RStudio_files/figure-html//1eypYLLqD11-NwHLs4adGpcuSB07dYEJfAaALSMvgzqw_ge1182913a6_0_20.png" title="Screenshot of the cloud environment popout. &quot;Delete environment options&quot; is highlighted." alt="Screenshot of the cloud environment popout. &quot;Delete environment options&quot; is highlighted." width="480" />

1. If you are certain that you do not need the data and configuration on your disk, you should select "Delete everything, including persistent disk".

    <img src="resources/images/04-RStudio_files/figure-html//1eypYLLqD11-NwHLs4adGpcuSB07dYEJfAaALSMvgzqw_ge1182913a6_0_46.png" title="Screenshot of the cloud environment popout. &quot;Delete everything, including persistent disk&quot; is highlighted." alt="Screenshot of the cloud environment popout. &quot;Delete everything, including persistent disk&quot; is highlighted." width="480" />

1. Select "DELETE".

    <img src="resources/images/04-RStudio_files/figure-html//1eypYLLqD11-NwHLs4adGpcuSB07dYEJfAaALSMvgzqw_ge1182913a6_0_51.png" title="Screenshot of the cloud environment popout. &quot;Delete&quot; is highlighted." alt="Screenshot of the cloud environment popout. &quot;Delete&quot; is highlighted." width="480" />

## Video Guide

In addition to the steps above, you can review this video guide on how to launch RStudio on AnVIL.

<iframe src="https://drive.google.com/file/d/1v72ZG8JIRDUaewFQgGfcCO_qoM4eYmYX/preview" width="640" height="360" allow="autoplay"></iframe>

The slides for this tutorial are are located [here](https://docs.google.com/presentation/d/1eypYLLqD11-NwHLs4adGpcuSB07dYEJfAaALSMvgzqw).


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
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## loaded via a namespace (and not attached):
##  [1] knitr_1.33      magrittr_2.0.3  hms_1.1.1       R6_2.5.1       
##  [5] rlang_1.0.2     fastmap_1.1.0   fansi_1.0.3     highr_0.9      
##  [9] httr_1.4.2      stringr_1.4.0   tools_4.1.3     xfun_0.26      
## [13] png_0.1-7       utf8_1.2.2      cli_3.2.0       jquerylib_0.1.4
## [17] htmltools_0.5.2 ellipsis_0.3.2  ottrpal_1.0.1   yaml_2.3.5     
## [21] digest_0.6.29   tibble_3.1.6    lifecycle_1.0.1 crayon_1.5.1   
## [25] bookdown_0.24   tzdb_0.3.0      readr_2.1.2     sass_0.4.1     
## [29] vctrs_0.4.1     fs_1.5.2        curl_4.3.2      glue_1.6.2     
## [33] evaluate_0.15   rmarkdown_2.10  stringi_1.7.6   pillar_1.7.0   
## [37] compiler_4.1.3  bslib_0.3.1     jsonlite_1.8.0  pkgconfig_2.0.3
```
