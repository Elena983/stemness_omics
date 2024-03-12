## Stemness for Visium data

Using ML model for different omics

A machine learning [one-class logistic regression model to predict stemness for single-cell transcriptomics and spatial omics](https://bmcgenomics.biomedcentral.com/articles/10.1186/s12864-023-09722-6)

We need to load the stemness model (gene weight) further to score it against your gene/protein matrix using a Spearman correlation.
In the end, you scale those correlations between 0 and 1 - what we call the stemness index.

The model was trained on iPS/ES cells from a public database. 
It was based on bulk RNA sequencing. At the end, the model counts on ~12k genes with a weight for each respective gene towards the iPS/ES profile 
(the gene list that defines pluripotency and establishes a baseline for the pluripotent state)

The model was primarily designed using gene expression data. However, we’ve also tried to extend its application to include spatial proteomics. 
The results from our paper show robustness when applied to transcriptomics and proteomics data, although this usage is still being understood as it grows.

1. Visium data

![5626e171-d519-4fe4-8f2a-1dc7f6e55047](https://github.com/Elena983/stemness_omics/assets/68946912/eb04f52a-f76d-45d7-8d20-ce9aa2186b0e)

## COMET data

spe.Rds object for patient1 and patient3 based on [steinbock](https://github.com/Elena983/steinbock) analysis

This model highlights the importance of understanding where more aggressive, stem-like cells are situated in the tumor and the TME that surrounds them.  This method also addresses the problems of proper cell annotation such that cells, regardless of their annotated cell identity, can be appropriately identified based on their level of stemness.

It's also true that the presence and activity of T cells, particularly helper T cells (CD4+) and cytotoxic T cells (CD8+), play a crucial role in the body's immune response against cancer cells. However, in cancers with high stemness scores, there tends to be a suppressed immune response, which can result in fewer T cells infiltrating the tumor microenvironment.  

If few T cells are present in tumors with high stemness scores, this may indicate a compromised immune response and potentially suggest the need for immunotherapeutic approaches to boost T cell activity and enhance anti-tumor immunity.

# Calculating the stemness score for the multiplex proteomics

![image](https://github.com/Elena983/stemness_omics/assets/68946912/3c6a7832-3d7e-4956-968e-69aae131fee1)

![image](https://github.com/Elena983/stemness_omics/assets/68946912/a61442e4-d22e-467b-b0f5-d2c955417d06)

When many T cells in both samples exhibit a high stemness score, it typically occurs in the early stages of immune responses, such as during acute infections or following vaccination. These T cells possess characteristics of stem-like cells, including self-renewal capacity, multipotency, and functional persistence. They are often found among naïve and some memory T cell subsets, indicating their ability to maintain long-term immunity and respond robustly to antigenic stimulation.

In the context of cancer, when many T cells exhibit a high stemness score, it suggests the presence of "precursors of exhausted" T (TPEX) cells rather than fully exhausted T (TEX) cells. These TPEX cells retain stem-like properties and have the potential for functional persistence and response to immunotherapies. High stemness scores in cancer indicate the presence of T cells that could be targeted and invigorated by checkpoint blockade therapies to enhance their anti-tumor responses (Gonzalez, 2021).


Gonzalez, N. M., Zou, D., Gu, A., & Chen, W. (2021). Schrödinger's T Cells: Molecular Insights Into Stemness and Exhaustion. Frontiers in immunology, 12, 725618. https://doi.org/10.3389/fimmu.2021.725618

