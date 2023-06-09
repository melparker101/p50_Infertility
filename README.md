# p50 Infertility Project

### Tasks
This repository contains code used for the p50 infertility project. There are two separate tasks:
- Running [CELLECT](https://github.com/melparker101/p50_Infertility/tree/main/CELLECT) on ovary datasets with infertility and hormone GWAS sumstats to prioritise etiologic cell types.
- Finding [marker genes](https://github.com/melparker101/p50_Infertility/tree/main/cluster_marker_genes) for clusters from the ovary datasets.

### Preparing datasets
- See [datasets](https://github.com/melparker101/p50_Infertility/tree/main/datasets) for more information on the datasets used for this part of the p50 project. 
- The [preprocessing](https://github.com/melparker101/p50_Infertility/tree/main/preprocessing) directory contains code for
    - filtering datasets to only include relevant samples 
    - creating h5seurat files (R Seurat object) from the scRNA-seq data required for finding cluster gene markers 
    - converting the h5seurat files to h5ad files (python Anndata object) to prepare for CELLEX. Where cell-type annotations are not availible online, the code includes clustering and annotating cell types using Seurat. 
