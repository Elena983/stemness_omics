# stemness_omics

using ML model for different omics

A machine learning one-class logistic regression model to predict stemness for single-cell transcriptomics and spatial omics
https://bmcgenomics.biomedcentral.com/articles/10.1186/s12864-023-09722-6

We need to load the stemness model (gene weight) further to score it against your gene/protein matrix using a Spearman correlation.
In the end, you scale those correlations between 0 and 1 - what we call the stemness index.

The model was trained on iPS/ES cells from a public database. 
It was based on bulk RNA sequencing. At the end, the model counts on ~12k genes with a weight for each respective gene towards the iPS/ES profile 
(the gene list that defines pluripotency and establishes a baseline for the pluripotent state)

The model was primarily designed on top of gene expression data. However, we’ve tried to extend its application to include spatial proteomics as well. 
The results from our paper have shown robustness when applying it to both transcriptomics and proteomics data. Although this usage is still being understood as it grows.

1. Visium data

![5626e171-d519-4fe4-8f2a-1dc7f6e55047](https://github.com/Elena983/stemness_omics/assets/68946912/eb04f52a-f76d-45d7-8d20-ce9aa2186b0e)

ongoing for other spatial techniques
