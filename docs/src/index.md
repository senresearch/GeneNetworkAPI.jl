```@meta
CurrentModule = GeneNetworkAPI
```

# Overview

```@index
```
The [GeneNetworkAPI](https://github.com/sens/GeneNetworkAPI.jl) package provides 
access to the [GeneNetwork](http://genenetwork.org) database
and analysis functions using the [GeneNetwork REST
API](https://github.com/genenetwork/gn-docs/blob/master/api/GN2-REST-API.md).

## Credits

Pjotr Prins and Zach Sloan are the main contributors to the
GeneNetwork REST API.  Karl Broman wrote the
[GNapi](https://github.com/kbroman/GNapi/blob/main/README.md) R
package for providing access to GeneNetwork from R.  This package
follows the structure and function of that package closely.

## Note on terminology

GeneNetwork collects data on genetically segregating populations
(called _groups_) in a number of _species_ including humans.  Most of
the phenotype data is "omic" data which are organized as _datasets_. 

```@setup gnapi
using GeneNetworkAPI
```

## Check connection

To check if the website is responding properly:

```@repl gnapi
check_gn()
```

## Get species list

Which species have data on them?

```@repl gnapi
list_species()
```

To get information on a single species:

```@repl gnapi
list_species("rat")
```

You could also subset (safer):

```@repl gnapi
GeneNetworkAPI.subset(list_species(), :Name => x->x.=="rat")
```

## List groups for a species

Since the information is organized by segregating population
("group"), it is useful to get a list for a preticular species you
might be interested in.

```@repl gnapi
ENV["COLUMNS"] = 150; #hide
list_groups("rat")
```

You can see the type of population it is.  Note the short name
(`Name`) as that will be used in queries involving that population
(group).


## Get genotypes for a group

To get the genotypes of a group:


```@repl gnapi
ENV["COLUMNS"] = 150; #hide
get_geno("BXD") |> (x->first(x,10))
```

Currently, we only support the `.geno` format which returns a data
frame of genotypes with rows as marker and columns as individuals.

## List datasets for a group

To list the (omic) datasets available for a group, you have to use the
name as listed in the group list for a species:

```@repl gnapi
ENV["COLUMNS"] = 150; #hide
list_datasets("HSNIH-Palmer")
```

## Get sample data for a group

This gives you a matrix with rows as individuals/samples/strains and
columns as "clinical" (non-omic) phenotypes.  The number after the
underscore is the phenotype number (to be used later).  Some data may
be missing.

```@repl gnapi
ENV["COLUMNS"] = 150; #hide
get_pheno("HSNIH-Palmer") |> (x->x[81:100,:]) |> show
```

## Get information about traits

To get information on a particular (non-omic) trait use the group name
and the trait number:

```@repl gnapi
ENV["COLUMNS"] = 100; #hide
info_dataset("HSNIH-Palmer","10308")
```

To get information on a dataset (of omic traits) for a group, use:

```@repl gnapi
ENV["COLUMNS"] = 150; #hide
info_dataset("HSNIH-Rat-Acbc-RSeq-Aug18")

```

## Summary information on traits

Get a list of the maximum LRS for each trait and position.

```@repl gnapi
ENV["COLUMNS"] = 100; #hide
info_pheno("HXBBXH") |> (x->first(x,10))
```

You could also specify a group and a trait number or a dataset and a probename.

```@repl gnapi
info_pheno("BXD","10001")
```

```@repl gnapi
ENV["COLUMNS"] = 150; #hide
info_pheno("HC_M2_0606_P","1436869_at")
```

## Analysis commands


### GEMMA

```@repl gnapi
run_gemma("BXDPublish","10015",use_loco=true) |> (x->first(x,10))
```

### R/qtl

This function performs a one-dimensional genome scan.  The arguments
are

- db (required) - DB name for trait above (Short_Abbreviation listed
  when you query for datasets)
- trait (required) - ID for trait being mapped
- method - hk (default) | ehk | em | imp | mr | mr-imp |
  mr-argmax ; Corresponds to the "method" option for the R/qtl scanone
  function.
- model - normal (default) | binary | 2-part | np ; corresponds
  to the "model" option for the R/qtl scanone function
- n_perm - number of permutations; 0 by default
- control_marker - Name of marker to use as control; this relies on
  the user knowing the name of the marker they want to use as a
  covariate
- interval_mapping - Whether to use interval mapping; "false" by default

```@repl gnapi
run_rqtl("BXDPublish", "10015") |> (x->first(x,10))
```

### Correlation

This function correlates a trait in a dataset against all traits in a
target database.


- trait_id (required) - ID for trait used for correlation
- db (required) - DB name for the trait above (this is the Short_Abbreviation listed when you query for datasets)
- target_db (required) - Target DB name to be correlated against
- type - sample (default) | tissue
- method - pearson (default) | spearman
- return - Number of results to return (default = 500)


```@repl gnapi
run_correlation("1427571_at","HC_M2_0606_P","BXDPublish") |> (x->first(x,10))
```

```@autodocs
Modules = [GeneNetworkAPI]
```
