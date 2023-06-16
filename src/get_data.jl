# This file contains the functions to get data from gene network APIs

############################
# Functions returning data #
############################

#############
# Geno data #
#############

"""                                                                                    
    get_geno(group::String,format::String="geno";gn_url::String=gn_url())

Returns the genotype matrix for a `group` in a given `format`.

Currently works only for files in the `geno` format.
"""
function get_geno(group, format="geno"; gn_url::String=gn_url())
    
    geno_file = download_geno(group, format;gn_url = gn_url)

    geno = parse_geno(geno_file)

    return geno
end

##############
# Pheno data #
##############

"""                                                                                    
    get_pheno(dataset::String;gn_url::String=gn_url())

Returns the non-omic ("clinical") phenotypes for a given `dataset`.

---

    get_pheno(dataset::String,trait::String; gn_url::String=gn_url())

Returns a given `trait` in a `group`.
"""
function get_pheno(dataset::String; gn_url::String=gn_url())
    pheno_file = download_pheno(dataset; gn_url = gn_url)   
    return CSV.read(pheno_file, DataFrame, delim=',',missingstring="x")
end

function get_pheno(dataset::String,trait::String; gn_url::String=gn_url())
    url = gn_url * "sample_data" * "/" * dataset * "/" * trait 
    return json2df(get_api(url))
end


##############
# Omics data #
##############

"""                                                                                    
    get_omics(dataset::String;gn_url::String=gn_url())

Returns the omic phenotypes for a given `dataset`.
"""
function get_omics(dataset::String; gn_url::String=gn_url())
    omics_file = download_omics(dataset; gn_url= gn_url)
    return CSV.read(omics_file, DataFrame, delim=',',missingstring="x")
end