# Functions

```@meta
CurrentModule = GeneNetworkAPI
```

```@index
```

## Server functions

```@docs
GeneNetworkAPI.gn_url
GeneNetworkAPI.check_gn
```

## List what's in the database

```@docs
GeneNetworkAPI.list_datasets
GeneNetworkAPI.list_groups
GeneNetworkAPI.list_species
GeneNetworkAPI.list_geno
```

## Get data and information

```@docs
GeneNetworkAPI.get_geno
GeneNetworkAPI.get_pheno
GeneNetworkAPI.get_omics
GeneNetworkAPI.info_dataset
GeneNetworkAPI.info_pheno

```
## Download data

```@docs
GeneNetworkAPI.download_geno
GeneNetworkAPI.download_pheno
GeneNetworkAPI.download_omics
```

## Display table

```@docs
GeneNetworkAPI.show_table
```

## Utils

```@docs
GeneNetworkAPI.make_rectangular
GeneNetworkAPI.has_error_500
GeneNetworkAPI.parse_geno
GeneNetworkAPI.genofile_location
GeneNetworkAPI.has_genofile_meta
```

## Run jobs on the server

```@docs
GeneNetworkAPI.run_correlation
GeneNetworkAPI.run_gemma
GeneNetworkAPI.run_rqtl
```
