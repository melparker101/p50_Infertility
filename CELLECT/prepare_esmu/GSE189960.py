import scanpy as sc
import pandas as pd
import cellex

dataset_acc = "GSE189960"

# Define data paths
dirIn = 'data/counts/' + dataset_acc + '/'  
dirOut = 'data/esmu'
  
input_file = dataset_acc + "_counts.h5ad"
refixData_ens = dataset_acc + '_ens'

# Read in data
adata = sc.read_h5ad(dirIn + input_file)

# Extract metadata
metadata = pd.DataFrame(adata.obs["cell_type"], columns=["cell_type"])

# Extract raw count data
raw = adata.raw.to_adata()
raw = raw.transpose()
mat = raw.to_df()
mat

# Check how many cells there are of each cell type
print(metadata.groupby('cell_type').cell_type.count())

### Run CELLEX ###
# Compute ESO object
eso = cellex.ESObject(data=mat, annotation=metadata, verbose=True)

# Compute ESw, ESw* and ESmu
eso.compute(verbose=True)

# Save and inspect results
# Save expression specificity mu and sd matrix for gene symbols
# eso.save_as_csv(file_prefix=prefixData_sym, path=dirOut, verbose=True)
eso.results["esmu"].head()

# Map symbols to ensembl ids
cellex.utils.mapping.human_symbol_to_human_ens(eso.results["esmu"], drop_unmapped=True, verbose=True)
eso.results["esmu"].head()

# Save expression specificity matrix for gene ensembl ids
eso.save_as_csv(file_prefix=prefixData_ens, path=dirOut, verbose=True)

# Delete object to release memory
del eso
