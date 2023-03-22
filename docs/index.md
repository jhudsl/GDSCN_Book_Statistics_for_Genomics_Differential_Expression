---
title: "Statistics for Genomics: Differential Expression"
date: "March 22, 2023"
site: bookdown::bookdown_site
documentclass: book
bibliography: book.bib
biblio-style: apalike
link-citations: yes
description: Description about Course/Book.
favicon: assets/GDSCN_style/gdscn_favicon.ico
---


# About this Book {-}

This book is part of a series of books for the Genomic Data Science Analysis, Visualization, and Informatics Lab-space (AnVIL) of the National Human Genome Research Institute (NHGRI). Learn more about AnVIL by visiting `https://anvilproject.org` or reading the [article in Cell Genomics](https://www.sciencedirect.com/science/article/pii/S2666979X21001063).

This work is also supported in part by the Genomic Data Science Community Network (GDSCN), a faculty network working toward a vision where researchers, educators, and students from diverse backgrounds are able to fully participate in genomic data science research. We encourage you to check out the GDSCN [preprint](https://arxiv.org/abs/2201.08443).

## AnVIL Collection {-}

Please check out our full collection of AnVIL resources below!

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Book Name </th>
   <th style="text-align:left;"> Description </th>
   <th style="text-align:left;"> Topics </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> [AnVIL Phylogenetic-Techniques](https://jhudatascience.org/AnVIL_Phylogenetic-Techniques/) ([github](https://github.com/jhudsl/AnVIL_Phylogenetic-Techniques)) </td>
   <td style="text-align:left;"> A semester-long course on the basics of molecular phylogenetic techniques </td>
   <td style="text-align:left;"> anvil, r-programming </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [AnVIL SRA Data](https://hutchdatascience.org/AnVIL_SRA_Data/) ([github](https://github.com/fhdsl/AnVIL_SRA_Data)) </td>
   <td style="text-align:left;"> Pull Sequence Read Archive (SRA) data into AnVIL </td>
   <td style="text-align:left;"> anvil, genomics, ncbi-database, sequence-read-archive </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [AnVIL Urban Genomics PCA](https://hutchdatascience.org/AnVIL_Urban_Genomics_PCA/) ([github](https://github.com/fhdsl/AnVIL_Urban_Genomics_PCA)) </td>
   <td style="text-align:left;"> Lab module and lectures for exploring PCA using feral pigeon populations </td>
   <td style="text-align:left;"> anvil, genomics, pca, urban-data-science </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [AnVIL: Epigenetics Intro](https://hutchdatascience.org/AnVIL_Book_Epigenetics_Intro/) ([github](https://github.com/fhdsl/AnVIL_Book_Epigenetics_Intro)) </td>
   <td style="text-align:left;"> An introductory activity for epigenetics, or the idea of &quot;nature versus nurture&quot; in genetics. Learners use the UCSC Genome Browser. </td>
   <td style="text-align:left;"> anvil, course, epigenetics, human-genomes, module, ucsc-browser </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [AnVIL: Getting Started](https://jhudatascience.org/AnVIL_Book_Getting_Started) ([github](https://github.com/jhudsl/AnVIL_Book_Getting_Started)) </td>
   <td style="text-align:left;"> A guide for getting started using AnVIL </td>
   <td style="text-align:left;"> anvil, cloud-computing </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [AnVIL: Instructor Guide](https://jhudatascience.org/AnVIL_Book_Instructor_Guide) ([github](https://github.com/jhudsl/AnVIL_Book_Instructor_Guide)) </td>
   <td style="text-align:left;"> A guide for instructors using AnVIL for workshops, lessons, or courses. </td>
   <td style="text-align:left;"> anvil, education </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [GDSCN SARS RStudio on AnVIL](https://hutchdatascience.org/GDSCN_SARS_RStudio_on_AnVIL/) ([github](https://github.com/fhdsl/GDSCN_SARS_RStudio_on_AnVIL)) </td>
   <td style="text-align:left;"> Lab module and lectures for identifying phylogenetic history of SARS variants using R </td>
   <td style="text-align:left;"> anvil, gdscn, phylogenetic-analysis, sars-cov-2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [GDSCN: SARS Galaxy on AnVIL](https://jhudatascience.org/GDSCN_Book_SARS_Galaxy_on_AnVIL/) ([github](https://github.com/jhudsl/GDSCN_Book_SARS_Galaxy_on_AnVIL)) </td>
   <td style="text-align:left;"> Lab module and lectures for variant detection in SARS-CoV-2 using Galaxy </td>
   <td style="text-align:left;"> anvil, gdscn, genomics, module, sars-cov-2, variant-detection </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [GDSCN: Statistics for Genomics Differential Expression](https://jhudatascience.org/GDSCN_Book_Statistics_for_Genomics_Differential_Expression/) ([github](https://github.com/jhudsl/GDSCN_Book_Statistics_for_Genomics_Differential_Expression)) </td>
   <td style="text-align:left;"> A set of lab modules for an introduction to differential gene expression </td>
   <td style="text-align:left;"> anvil, cloud-computing, gdscn, gene-expression </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [GDSCN: Statistics for Genomics PCA](https://jhudatascience.org/GDSCN_Book_Statistics_for_Genomics_PCA/) ([github](https://github.com/jhudsl/GDSCN_Book_Statistics_for_Genomics_PCA)) </td>
   <td style="text-align:left;"> A set of lab modules for PCA analysis </td>
   <td style="text-align:left;"> anvil, gdscn, genomics </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [GDSCN: Statistics for Genomics scRNA-seq](http://jhudatascience.org/GDSCN_Book_Statistics_for_Genomics_scRNA-seq/) ([github](https://github.com/jhudsl/GDSCN_Book_Statistics_for_Genomics_scRNA-seq)) </td>
   <td style="text-align:left;"> A set of lab modules for single cell RNA-seq analysis </td>
   <td style="text-align:left;"> anvil, gdscn, rna-seq, scrna-seq </td>
  </tr>
</tbody>
</table>
