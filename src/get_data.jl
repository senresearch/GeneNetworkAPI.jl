# June 3rd, 2019
# Author: Chelsea Trotter
# This file contains the functions to get data from gene network APIs

include("./api-process.jl")



function gn_url()
    return url = "http://gn2-zach.genenetwork.org/api/v_pre1"
end

# query genotype data. 
function get_geno(group; gn_url=gn_url())
    # TODO: stopifnot(length(dataset) ==1)
    geno_url = gn_url * "/genotypes" * "/" * group
    return process_csv_file(get_api(geno_url), delim='\t', comments=true)
end

function get_pheno(dataset; trait="", gn_url=gn_url())
    
    if (length(trait) == 0)
        pheno_url = gn_url * "/sample_data" * "/" * dataset 
        return process_csv_file(get_api(pheno_url), delim=',', comments = false)
    else 
        trait_url = gn_url * "/sample_data" * "/" * dataset * "/" * trait 
        return parse_json(get_api(trait_url))
    end
end
