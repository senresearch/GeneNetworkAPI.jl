# This file contains the functions to get data from gene network APIs

############################
# Functions returning data #
############################
"""                                                                                    
    get_geno(group::String,format::String="geno";gn_url::String=gn_url())

Returns the genotype matrix for a `group` in a given `format`.

Currently works only for files in the `geno` format.
"""
function get_geno(group, format="geno"; gn_url::String=gn_url())
    
    if has_genofile_meta(group; gn_url=gn_url)
        # need to check real location of data
        vlocation = genofile_location(group; gn_url=gn_url)
        
        if length(vlocation) == 1 
            group = vlocation[1][1:end-5] # expect ".geno" extension
        # else
            # println("Info: group ", group, " has additional genotype files, see locations")
            # show_table(list_geno(group; gn_url=gn_url))
        end
    end

    geno_url = gn_url * "genotypes/" * group * "." * format
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

Returns a given `trait` in a `group`.
"""
function get_pheno(dataset::String,trait::String; gn_url::String=gn_url())
    url = gn_url * "/sample_data" * "/" * dataset * "/" * trait 
    return json2df(get_api(url))
end

