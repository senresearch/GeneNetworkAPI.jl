# June 3rd, 2019
# Author: Chelsea Trotter
# This file contains the functions to get data from gene network APIs

function gn_url()
    return url = "http://gn2.genenetwork.org/api/v_pre1/"
end

# # query genotype data. 
# function get_geno(group; gn_url=gn_url())
#     geno_url = gn_url * "/genotypes" * "/" * group
#     # take care of extra comment symbol @ in geno file
#     data = replace(get_api(geno_url), "\n@" => "\n#")
#     return str2df(data, delim='\t', comments=true)
# end

# get genotype data
function get_geno(group, format="geno", gn_url=gn_url())
    geno_url = gn_url * "/genotypes" * "/" * group * "." * format
    geno = parse_geno(Downloads.download(geno_url))
    return geno
end

function get_pheno(dataset::String; gn_url=gn_url())
    url = gn_url * "/sample_data" * "/" * dataset * "Publish"
    return CSV.read(Downloads.download(url), DataFrame, delim=',')
end

function get_pheno(dataset::String,trait::String; gn_url=gn_url())
    url = gn_url * "/sample_data" * "/" * dataset * "/" * trait 
    return json2df(get_api(url))
end

function list_species(species="", gn_url=gn_url())
    if (length(species) != 0)
        url = gn_url * "species/" * species 
    else
        url = gn_url * "species"
    end
    return json2df(get_api(url))
end

function list_groups(species="", gn_url=gn_url())
    if(length(species) != 0)
        url = gn_url * "groups/" * species
    else 
        url = gn_url * "groups"
    end
    return json2df(get_api(url))
end

function list_datasets(group;gn_url=gn_url())
    url = gn_url * "datasets/"  * group
    return json2df(get_api(url))
end

function info_dataset(dataset, trait=""; gn_url = gn_url())
    if(length(trait) != 0)
        url = gn_url * "dataset/" * dataset * "/" * trait
    else 
        url = gn_url * "dataset/" * dataset 
    end
    return json2df(get_api(url))
end

function info_pheno(group::String, trait::String, gn_url=gn_url())
    url = gn_url * "trait/" * group * "/" * trait
    return json2df(get_api(url))
end

function info_pheno(group::String, gn_url=gn_url())
    url = gn_url * "traits/" * group * "Publish.json"
    return json2df(get_api(url))
end

function run_gemma(dataset, trait; use_loco=false, maf=0.01, gn_url=gn_url())
    loco = use_loco == true ? "true" : "false"
    url = gn_url * "mapping?trait_id=" * trait * "&db=" * dataset * "&method=gemma" * "&use_loco=" * loco * "&maf=" * string(maf)
    return get_api(url) |> JSON.parse |> (x->x[1]) |> j2m
end

function run_rqtl(dataset, trait; method="hk", model="normal", n_perm=0, control_marker="", interval_mapping=false, gn_url=gn_url())

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
    url = gn_url * "mapping?trait_id=" * trait * "&db=" * dataset * "&method=rqtl" * "&rqtl_method=" * method * "&rqtl_model=" * model * "&interval_mapping=" * im 

    return json2df(get_api(url))
end

function run_correlation(trait, dataset, group; t="sample", method="pearson", n_result=500, gn_url=gn_url())
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

