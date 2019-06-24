include("../src/get_data.jl")
# *********************************************************************************************

# Fetching Species List
# curl http://gn2-zach.genenetwork.org/api/v_pre1/species
# [ { "FullName": "Mus musculus", "Id": 1, "Name": "mouse", "TaxonomyId": 10090 }, ... { "FullName": "Populus trichocarpa", "Id": 10, "Name": "poplar", "TaxonomyId": 3689 } ]
# Or to get a single species info:
# curl http://gn2-zach.genenetwork.org/api/v_pre1/species/mouse
# ls = list_species()
# ls1 = list_species("mouse")


# Fetch Groups/RISets
# This query can optionally filter by species:
# curl http://gn2-zach.genenetwork.org/api/v_pre1/groups (for all species)
# curl http://gn2-zach.genenetwork.org/api/v_pre1/mouse/groups (for just mouse groups/RISets)
# OR 
# [ { "DisplayName": "BXD", "FullName": "BXD RI Family", "GeneticType": "riset", "Id": 1,
# lg = list_groups()
# lg1 = list_groups("mouse")


# Fetch Genotypes for Group/RISet
# curl http://gn2-zach.genenetwork.org/api/v_pre1/genotypes/BXD
# Returns a CSV file with metadata in the first few rows, sample/strain names as columns, and markers as rows. Currently only works for genotypes we have stored in .geno files; I'll add the option to download BIMBAM files soon.
# geno_data = get_geno("BXD") 
# Works. TODO: currently returns 2d array of Any. Need to convert to dataframe.   

# Fetch Datasets
# curl http://gn2-zach.genenetwork.org/api/v_pre1/datasets/bxd
# curl http://gn2-zach.genenetwork.org/api/v_pre1/datasets/mouse/bxd
# [ { "AvgID": 1, "CreateTime": "Fri, 01 Aug 2003 00:00:00 GMT", "DataScale": "log2", "FullName": "UTHSC/ETHZ/EPFL BXD Liver Polar Metabolites Extraction A, CD Cohorts (Mar 2017) log2", "Id": 1, "Long_Abbreviation": "BXDMicroArray_ProbeSet_August03", "ProbeFreezeId": 3, "ShortName": "Brain U74Av2 08/03 MAS5", "Short_Abbreviation": "Br_U_0803_M", "confidentiality": 0, "public": 0 }, ... { "AvgID": 3, "CreateTime": "Tue, 14 Aug 2018 00:00:00 GMT", "DataScale": "log2", "FullName": "EPFL/LISP BXD CD Liver Affy Mouse Gene 1.0 ST (Aug18) RMA", "Id": 859, "Long_Abbreviation": "EPFLMouseLiverCDRMAApr18", "ProbeFreezeId": 181, "ShortName": "EPFL/LISP BXD CD Liver Affy Mouse Gene 1.0 ST (Aug18) RMA", "Short_Abbreviation": "EPFLMouseLiverCDRMA0818", "confidentiality": 0, "public": 1 } ]
# ds = list_datasets("bxd")


# Fetch Sample Data for Dataset 
# curl http://gn2-zach.genenetwork.org/api/v_pre1/sample_data/HSNIH-PalmerPublish.csv
# Returns a CSV file with sample/strain names as the columns and trait IDs as rows

# Fetch Sample Data for Single Trait
# curl http://gn2-zach.genenetwork.org/api/v_pre1/sample_data/HC_M2_0606_P/1436869_at
# [ { "data_id": 23415463, "sample_name": "129S1/SvImJ", "sample_name_2": "129S1/SvImJ", "se": 0.123, "value
# pheno_data = get_pheno("HSNIH-PalmerPublish")
# pheno_data1 = get_pheno("BXD", trait="10002")
# pheno_data1 = get_pheno("HC_M2_0606_P", trait="1436869_at")

# # Fetch Individual Dataset Info
# For mRNA Assay/"ProbeSet"
# curl http://gn2-zach.genenetwork.org/api/v_pre1/dataset/HC_M2_0606_P
# OR 
# curl http://gn2-zach.genenetwork.org/api/v_pre1/dataset/bxd/HC_M2_0606_P
# (This also has the option to specify group/riset)
# For "Phenotypes" (basically non-mRNA Expression; stuff like weight, sex, etc)
# curl http://gn2-zach.genenetwork.org/api/v_pre1/dataset/bxd/10001
# { "dataset_type": "phenotype", "description": "Central nervous system, morp

# info_dataset("HC_M2_0606_P")
# info_dataset("bxd", trait="HC_M2_0606_P")
# info_dataset("bxd", trait="10001")
# TODO: better naming for the arguments in info_dataset



# # Fetch Trait Info (Name, Description, Location, etc)
# For mRNA Expression/"ProbeSet"
# curl http://gn2-zach.genenetwork.org/api/v_pre1/trait/HC_M2_0606_P/1436869_at
# { "additive": -0.214087568058076, "alias": "HHG1; HLP3; HPE3; SMMCI; Dsh; Hhg1", "chr": "5", "description": "sonic hedgehog (hedgehog)", "id": 99602, "locus": "rs8253327", "lrs": 12.7711275309832, "mb": 28.457155, "mean": 9.27909090909091, "name": "1436869_at", "p_value": 0.306, "se": null, "symbol": "Shh" }
info_pheno("HC_M2_0606_P", "1436869_at")


# For "Phenotypes"
# For phenotypes this just gets the max LRS, its location, and additive effect (as calculated by qtlreaper)
# Since each group/riset only has one phenotype "dataset", this query takes either the group/riset name or the group/riset name + "Publish" (for example "BXDPublish", which is the dataset name in the DB) as inpu
# curl http://gn2-zach.genenetwork.org/api/v_pre1/trait/BXD/10001
# { "additive": 2.39444435069444, "id": 4, "locus": "rs48756159", "lrs": 13.4974911471087 }
info_pheno("BXD", "10001")
