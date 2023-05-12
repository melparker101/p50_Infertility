# Datasets to annotate

| Acc No.     | Paper URL                                                                           | Dataset URL                                                                   | Cells  | Number of clusters | Github                                                                           | Done?              |
|-------------|-------------------------------------------------------------------------------------|-------------------------------------------------------------------------------|--------|--------------------|----------------------------------------------------------------------------------|--------------------|
| GSE189960   | https://pubmed.ncbi.nlm.nih.gov/35204732/                                           | https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE189960                  | 14,592 | 13                 | -                                                                                |                    |
| GSE202601   | https://www.biorxiv.org/content/biorxiv/early/2022/05/19/2022.05.18.492547.full.pdf | https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE202601                  | 42,568 | 8                  | https://github.com/ChenJin2020/The-regulatory-landscapes-of-human-ovarian-ageing |                    |
| GSE192722   | https://www.nature.com/articles/s42003-022-04384-8                                  | https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE192722                  | 48,147 | 22,6               | https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE192722                     |                    |
| GSE118127   | https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6639403/                               | https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE118127                  | 20,676 | 19,5               | https://github.com/johnmous/singleCell                                           |                    |
| E-MTAB-8381 | https://www.nature.com/articles/s41467-020-14936-3#data-availability                | https://www.ebi.ac.uk/gxa/sc/experiments/E-MTAB-8381/downloads?ref=biostudies | 24,329 | 18?,6              | https://github.com/wagmag/SingleCellOvary/tree/master                            | Do last. BAM files |
| GSE206143   | https://faseb.onlinelibrary.wiley.com/doi/10.1096/fj.202201746RR                    | https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE206143                  | 7609   | 19,13              | https://github.com/nurungji82/scRNA-seq_of_IVF_samples                           |                    |

Only datasets that had been annotated by the original authors with cell types of interest (e.g. cumulus, granulosa,theca,...) were used; other datasets were disgarded.

Exclude list:
- GSE184880 - not cell types of interest
- GSE166533 - only has 19 cells, in vitro, and oocytes
- GSE181955 - not the cell types of interest
- GSE107746 - too little cells
- PRJNA514416 - too little cells (oocytes)
- GSE44183 - too little cells (oocytes)
- GSE133856 - too little cells (oocytes)
- GSE36552 - too little cells (oocytes)
- E-MTAB-2983 - too little cells (older paper)
- EGAS00001006780 - post menopausal
- GSE213216 - not cell types of interest
- GSE186504 - not enough cells
- GSE154762 - not enough cells