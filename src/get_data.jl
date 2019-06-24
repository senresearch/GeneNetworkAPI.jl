# June 3rd, 2019
# Author: Chelsea Trotter
# This file contains the functions to get data from gene network APIs

include("./api-process.jl")



function gn_url()
    return url = "http://gn2-zach.genenetwork.org/api/v_pre1/"
end

# query genotype data. 
function get_geno(group; gn_url=gn_url())
    # TODO: stopifnot(length(dataset) ==1)
    geno_url = gn_url * "/genotypes" * "/" * group
    return process_csv_file(get_api(geno_url), delim='\t', comments=true)
end

function get_pheno(dataset; trait="", gn_url=gn_url())
    
    if (length(trait) == 0)
        url = gn_url * "/sample_data" * "/" * dataset 
        return process_csv_file(get_api(url), delim=',', comments = false)
        # return parse_json(get_api(pheno_url))
    else 
        url = gn_url * "/sample_data" * "/" * dataset * "/" * trait 
        return json2mat(get_api(url))
    end
end

function list_datasets(group;gn_url=gn_url())
    url = gn_url * "datasets/"  * group
    return json2mat(get_api(url))
end

function list_species(species="", gn_url=gn_url())
    if (length(species) != 0)
        url = gn_url * "species/" * species 
    else
        url = gn_url * "species"
    end
    return json2mat(get_api(url))
end

function list_groups(species="", gn_url=gn_url())
    if(length(species) != 0)
        url = gn_url * "groups/" * species
    else 
        url = gn_url * "groups"
    end
    return json2mat(get_api(url))
end

function info_dataset(dataset; trait="", gn_url = gn_url())
    if(length(trait) != 0)
        url = gn_url * "dataset/" * dataset * "/" * trait
    else 
        url = gn_url * "dataset/" * dataset 
    end
    return json2mat(get_api(url))
end

function info_pheno(group, trait, gn_url=gn_url())
    url = gn_url * "trait/" * group * "/" * trait
    return json2mat(get_api(url))
end
