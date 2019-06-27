include("../src/get_data.jl")
# *********************************************************************************************

# Fetching Species List
ls = list_species()
# Or to get a single species info:
ls1 = list_species("mouse")


# Fetch Groups/RISets
# This query can optionally filter by species:
lg = list_groups()
lg1 = list_groups("mouse")


# Fetch Genotypes for Group/RISet
geno_data = get_geno("BXD") 

# Fetch Datasets
ds = list_datasets("bxd")


# Fetch Sample Data for Dataset 
pheno_data = get_pheno("HSNIH-PalmerPublish")
# Fetch Sample Data for Single Trait
pheno_data1 = get_pheno("BXD", trait="10002")
pheno_data1 = get_pheno("HC_M2_0606_P", trait="1436869_at")

# # Fetch Individual Dataset Info
# For mRNA Assay/"ProbeSet"
info_dataset("HC_M2_0606_P")
# OR 
info_dataset("bxd", trait="HC_M2_0606_P")
# For "Phenotypes" (basically non-mRNA Expression; stuff like weight, sex, etc)
info_dataset("bxd", trait="10001")
# TODO: better naming for the arguments in info_dataset



# # Fetch Trait Info (Name, Description, Location, etc)
# For mRNA Expression/"ProbeSet"
df = info_pheno("HC_M2_0606_P", "1436869_at")


# For "Phenotypes"
info_pheno("BXD", "10001")

# Run analyses
# GEMMA:
run_gemma("BXDPublish", "10015", use_loco=true)

# R/qtl
run_rqtl("BXDPublish", "10015", method="em", interval_mapping=true)

# Calculate Correlation
run_correlation("HC_M2_0606_P", "BXDPublish", "1427571_at")
