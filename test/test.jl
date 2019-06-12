include("../src/api-process.jl")
include("../src/get_data.jl")

using DelimitedFiles
using BenchmarkTools

## Fetch species list

# To fetch a list of species:

```r
list_species()
```

# To get the information for a particular species:

```r
list_species("mouse")
```

## Fetch Groups/RISets

# List of groups:

```r
list_groups()
```

# List of groups/RISets for a given species

```r
list_groups("mouse")
```

## Fetch genotypes for Group/RIset

geno_data = get_geno("BXD")

## Fetch datasets

```r
list_datasets("bxd")
```
## Fetch sample data for dataset

pheno_data = get_pheno("HSNIH-PalmerPublish")

## Fetch individual dataset info

### For mRNA assay/probeset

```r
info_dataset("HC_M2_0606_P")
```

# Or provide group/riset

```r
info_dataset("bxd", "HC_M2_0606_P")
```

### Fetch individual phenotype info

```r
info_dataset("bxd", "10001")
```

## Fetch sample data for a single trait

```r
ph <- get_pheno("HC_M2_0606_P", "1436869_at")
```
trait_data = get_pheno("HC_M2_0606_P", trait = "1436869_at")

### For mRNA expression/probeset

```r
info_pheno("HC_M2_0606_P", "1436869_at")
```

### For classical phenotypes

```r
info_pheno("BXD", "10001")
```

## Analyses

### Gemma

```r
out <- run_gemma("BXDPublish", "10015", use_loco=TRUE)
```

### R/qtl

```r
out <- run_rqtl("BXDPublish", "10015", method="em", interval_mapping=TRUE)
```

### Correlations

```r
out <- run_correlation("HC_M2_0606_P", "BXDPublish", "1427571_at")
```

#returns single json
example_url = "http://gn2-zach.genenetwork.org/api/v_pre1/trait/BXD/10001" 

#returns multiple json
group_url = "http://gn2-zach.genenetwork.org/api/v_pre1/mouse/groups"
group_all_url = "http://gn2-zach.genenetwork.org/api/v_pre1/groups"

#returns a tab seperated value file. 
geno_url = "http://gn2-zach.genenetwork.org/api/v_pre1/genotypes/BXD"

dataset_url = "http://gn2-zach.genenetwork.org/api/v_pre1/datasets/mouse/bxd"
dataset_all_url = "http://gn2-zach.genenetwork.org/api/v_pre1/datasets/bxd"

sample_data_url = "http://gn2-zach.genenetwork.org/api/v_pre1/sample_data/HSNIH-PalmerPublish.csv"
"http://gn2-zach.genenetwork.org/api/v_pre1/sample_data/HC_M2_0606_P/1436869_at"


pheno_url = "http://gn2-zach.genenetwork.org/api/v_pre1/dataset/bxd/10001"

example_response = parse_json(get_api(example_url))
group_response = parse_json(get_api(group_url))

group_all_response = parse_json(get_api(group_all_url))

df = json2df_short(group_all_response)




# geno_data = get_geno("BXD")
# display(geno_data[1:5,1:5])

# sample_data = get_pheno("HSNIH-PalmerPublish")



