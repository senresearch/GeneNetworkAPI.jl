# GeneNetworkAPI

Provides access to the [GeneNetwork](http://genenetwork.org) database
and analysis functions using the [GeneNetwork REST
API](https://github.com/genenetwork/gn-docs/blob/master/api/GN2-REST-API.md).

Karl Broman wrote the
[GNapi](https://github.com/kbroman/GNapi/blob/main/README.md) R
package for providing access to GeneNetwork from R.  This package
follows th structure and function of that package closely.

## Note on terminology

GeneNetwork collects data on genetically segregating populations
(called _groups_) in a number of _species_ including humans.  Most of
the phenotype data is "omic" data which are organized as _datasets_. 

## Check connection

To check if the website is responding properly:
```
julia> check_gn()
GeneNetwork is alive.
200
```

## Get species list

Which species have data on them?

```
julia> list_species()
11×4 DataFrame
 Row │ FullName                           Id     Name             TaxonomyId 
     │ String                             Int64  String           Int64      
─────┼───────────────────────────────────────────────────────────────────────
   1 │ Mus musculus                           1  mouse                 10090
   2 │ Rattus norvegicus                      2  rat                   10116
   3 │ Arabidopsis thaliana                   3  arabidopsis            3702
   4 │ Homo sapiens                           4  human                  9606
   5 │ Hordeum vulgare                        5  barley                 4513
   6 │ Drosophila melanogaster                6  drosophila             7227
   7 │ Macaca mulatta                         7  macaque monkey         9544
   8 │ Glycine max                            8  soybean                3847
   9 │ Solanum lycopersicum                   9  tomato                 4081
  10 │ Populus trichocarpa                   10  poplar                 3689
  11 │ Oryzias latipes (Japanese medaka)     11  Oryzias latipes        8090
```

To get information on a single species:

```
julia> list_species("rat")
1×4 DataFrame
 Row │ FullName           Id     Name    TaxonomyId 
     │ String             Int64  String  Int64      
─────┼──────────────────────────────────────────────
   1 │ Rattus norvegicus      2  rat          10116
```

You could also subset (safer):
```
julia> subset(list_species(), :Name => x->x.=="rat")
1×4 DataFrame
 Row │ FullName           Id     Name    TaxonomyId 
     │ String             Int64  String  Int64      
─────┼──────────────────────────────────────────────
   1 │ Rattus norvegicus      2  rat          10116
```

## List groups for a species

Since the information is organized by segregating population
("group"), it is useful to get a list for a preticular species you
might be interested in.

```
julia> list_groups("rat")
7×8 DataFrame
 Row │ DisplayName                        FullName                           GeneticType  Id     MappingMethodId  Name             SpeciesId  public 
     │ String                             String                             String       Int64  String           String           Int64      Int64  
─────┼───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
   1 │ Hybrid Rat Diversity Panel (Incl…  Hybrid Rat Diversity Panel (Incl…  None            10  1                HXBBXH                   2       2
   2 │ UIOWA SRxSHRSP F2                  UIOWA SRxSHRSP F2                  intercross      24  1                SRxSHRSPF2               2       2
   3 │ NIH Heterogeneous Stock (RGSMC 2…  NIH Heterogeneous Stock (RGSMC 2…  None            42  1                HSNIH-RGSMC              2       2
   4 │ NIH Heterogeneous Stock (Palmer)   NIH Heterogeneous Stock (Palmer)   None            55  1                HSNIH-Palmer             2       2
   5 │ NWU WKYxF344 F2 Behavior           NWU WKYxF344 F2 Behavior           intercross      82  3                NWU_WKYxF344_F2          2       2
   6 │ HIV-1Tg and Control                HIV-1Tg and Control                None            83  1                HIV-1Tg                  2       2
   7 │ HRDP-HXB/BXH Brain Proteome        HRDP-HXB/BXH Brain Proteome        None            87  1                HRDP_HXB-BXH-BP          2       2
```

You can see the type of population it is.  Note the short name
(`Name`) as that will be used in queries involving that population
(group).

## Get genotypes for a group



