# June 3rd, 2019
# Author: Chelsea Trotter
# This file contains the functions to get data from gene network APIs

"""                                                                                    
    list_species(species::String="";gn_url::String=gn_url())

Returns a data frame with a list os species respresented in the
GeneNetwork database.  If the `species` string is non-empty, it will
return the information of the matched species.
"""
function list_species(species=""; gn_url::String=gn_url())
    if (length(species) != 0)
        url = gn_url * "species/" * species 
    else
        url = gn_url * "species"
    end
    return json2df(get_api(url))
end

"""                                                                                    
    list_groups(species::String="";gn_url::String=gn_url())

If `species` is not specified, then it returns all groups (segregating
populations) represented in the GeneNetwork database.  If the string
`species` is specified, then it returns all groups for that species.
"""
function list_groups(species=""; gn_url::String=gn_url())
    if(length(species) != 0)
        url = gn_url * "groups/" * species
    else 
        url = gn_url * "groups"
    end
    return json2df(get_api(url))
end

"""                                                                                    
    list_datasetss(group::String="";gn_url::String=gn_url())

Lists all datasets available in a specified `group`.
"""
function list_datasets(group::String; gn_url::String=gn_url())
    url = gn_url * "datasets/"  * group
    return json2df(get_api(url))
end

"""                                                                                    
    get_geno(group::String,format::String="geno";gn_url::String=gn_url())

Returns the genotype matrix for a `group` in a given `format`.

Currently works only for files in the `geno` format.
"""
function get_geno(group, format="geno"; gn_url::String=gn_url())
    geno_url = gn_url * "/genotypes" * "/" * group * "." * format
    geno = parse_geno(Downloads.download(geno_url))
    return geno
end

"""                                                                                    
    get_pheno(dataset::String;gn_url::String=gn_url())

Returns the non-omic ("clinical") phenotypes for a given `dataset`.
"""
function get_pheno(dataset::String; gn_url::String=gn_url())
    url = gn_url * "/sample_data" * "/" * dataset * "Publish"
    return CSV.read(Downloads.download(url), DataFrame, delim=',',missingstring="x")
end

"""                                                                                    
    get_pheno(group::String,trait::String="geno";gn_url::String=gn_url())

Returns a given 'trait` in a `group`.
"""
function get_pheno(dataset::String,trait::String; gn_url::String=gn_url())
    url = gn_url * "/sample_data" * "/" * dataset * "/" * trait 
    return json2df(get_api(url))
end


function info_dataset(dataset, trait=""; gn_url::String = gn_url())
    if(length(trait) != 0)
        url = gn_url * "dataset/" * dataset * "/" * trait
    else 
        url = gn_url * "dataset/" * dataset 
    end
    return json2df(get_api(url))
end

function info_pheno(group::String; gn_url::String=gn_url())
    url = gn_url * "traits/" * group * "Publish.json"
    return json2df(get_api(url))
end

function info_pheno(group::String, trait::String; gn_url::String=gn_url())
    url = gn_url * "trait/" * group * "/" * trait
    return json2df(get_api(url))
end

function run_gemma(dataset, trait; use_loco=false, maf=0.01, gn_url::String=gn_url())
    loco = use_loco == true ? "true" : "false"
    url = gn_url * "mapping?trait_id=" * trait * "&db=" * dataset * "&method=gemma" * "&use_loco=" * loco * "&maf=" * string(maf)
    return get_api(url) |> JSON.parse |> (x->x[1]) |> j2m
end

function run_rqtl(dataset, trait; method="hk", model="normal", n_perm=0, control_marker="", interval_mapping=false, gn_url::String=gn_url())

    methods = ["hk", "ehk", "em", "imp", "mr", "mr-imp", "mr-argmax"]
    models=["normal", "binary", "2part", "np"]
    if !(method in methods)
        error("Currently does not support $method in rqtl. Please select from hk, ehk, em, imp, mr, mr-imp, mr-argmax.")
    end
    if !(model in models)
        error("No $model model in rqtl. Please choose from normal, binary, 2part, np.")
    end

    im = interval_mapping == true ? "true" : "false"
    # run_rqtl("BXDPublish", "10015", method="em", interval_mapping=TRUE)
    url = gn_url * "mapping?trait_id=" * trait * "&db=" * dataset * "&method=rqtl" * "&rqtl_method=" * method * "&rqtl_model=" * model * "&num_perm=" * string(n_perm) * "&interval_mapping=" * string(interval_mapping)
    println(url)
    return json2df(get_api(url))
end

function run_correlation(trait, dataset, group; t="sample", method="pearson", n_result=500, gn_url::String=gn_url())
    types = ["sample", "tissue"]
    methods = ["pearson", "spearman"]

    if !(t in types)
        error("No $t type. Choose from sample and tissue")
    end
    if !(method in methods)
        error("Currently does not support $method in correlation. Choose from pearson and spearman.")
    end

    url = gn_url * "correlation" * "?trait_id=" * trait * "&db=" * dataset * "&target_db=" * group * "&type=" * "&method=" * method * "&return=" * string(n_result)
    return json2df(get_api(url))
end

