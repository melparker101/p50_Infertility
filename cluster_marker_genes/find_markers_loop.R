#################################################################
# Find Cluster Markers
# melodyjparker14@gmail.com - May 2023
# This code finds cluster markers for single cell RNA-seq datasets. 
# It takes a h5seurat as input and outputs tables with p-values.
#################################################################

library(Seurat)
library(SeuratDisk)
library(dplyr)

dataset_list <- c("GSE189960", "GSE192722", "GSE206143")

# Loop through datasets
for(dataset in dataset_list){
    
    # Define input and output variables
    dataset <- dataset
    path <- paste0("data/counts/",dataset)
    in_seurat <- paste0(path, "/", dataset, "_counts.h5Seurat")
    out_dir <- paste0("cluster_markers/", dataset)
    
    # Load in Seurat object
    seurat_ob <- LoadH5Seurat(in_seurat)
    seurat_ob

    # View metadata
    seurat_ob[["cell_type"]][1:20,]
    table(seurat_ob[["cell_type"]])

    ##### Find markers #####
    
    # Choose metadata column to use
    use_col <- "cell_type"

    # Set identity classes to the cell description
    Idents(object = seurat_ob) <- use_col
    levels(seurat_ob)

    # Create output directory
    dir.create(out_dir)

    # Create new directory for results of this cluster set
    clust_no <- paste0(length(levels(seurat_ob)),"C")
    cluster_dir <- paste(out_dir,clust_no,sep="/")
    dir.create(cluster_dir)

    # Find markers for every cluster compared to all remaining cells, report only the positive ones
    combined_markers <- FindAllMarkers(object = seurat_ob, 
                              only.pos = TRUE,
                              logfc.threshold = 0.25)  
    # View(combined_markers)

    # pval = 0 just means the p-value is too small for R to display
    # https://github.com/satijalab/seurat/issues/205

    # Order the rows by clusters, then by p-values
    combined_markers <- combined_markers %>% arrange(as.character(cluster), as.numeric(as.character(p_val)))
    combined_markers <- combined_markers %>% relocate(gene) %>% relocate(cluster)
    # View(combined_markers)
    head(combined_markers)

    # Write as table
    combined_out <- paste0(cluster_dir,"/combined_markers_" , clust_no,".txt")
    write.table(combined_markers,combined_out,sep="\t",quote = FALSE)

    # Find top 5 markers per cluster by 2-fold change
    top5_comb <- combined_markers %>%
            group_by(cluster) %>%
            top_n(n = 5,
                  wt = avg_log2FC)

    # View top 5 markers per cluster
    View(top5_comb)

    # Write as table
    top5_comb_out <- paste0(cluster_dir,"/top5_avglog2FC_comb_markers_",clust_no,".txt")
    write.table(top5_comb,top5_comb_out,sep="\t",quote = FALSE)

    # Check that there are no clusters with less than 3 cells
    table(seurat_ob$cell_type)

    # Find markers for each cluster and write to separate tables 
    cell_type_list <- levels(seurat_ob)
    for (cell_type in cell_type_list){
      # Extract and edit cell type names
      name <- paste(cell_type,"markers",sep="_")
      # Find markers
      value <- FindMarkers(seurat_ob, ident.1 = cell_type, only.pos = TRUE)
      # Reformat marker results table - order by pval and change col order
      value <- value %>% arrange(as.numeric(as.character(p_val)))
      assign(name, value)
      # Write to file
      out <- paste0(cluster_dir,"/",name,"_",clust_no,".txt")
      write.table(value,out,sep="\t",quote = FALSE)
      rm(name)
      rm(value)
    }

}
