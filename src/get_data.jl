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

    # increase timeout response from the server
    downloader = Downloads.Downloader();
    downloader.easy_hook = (easy, info) -> Downloads.Curl.setopt(easy, Downloads.Curl.CURLOPT_LOW_SPEED_TIME, 300);
    
    geno_url = gn_url * "genotypes/" * group * "." * format
    geno = parse_geno(Downloads.download(geno_url; downloader=downloader))

    return geno
end

##############
# Pheno data #
##############

"""                                                                                    
    get_pheno(dataset::String;gn_url::String=gn_url())

Returns the non-omic ("clinical") phenotypes for a given `dataset`.
"""
function get_pheno(dataset::String; gn_url::String=gn_url())
    url = gn_url * "sample_data" * "/" * dataset * "Publish"
    return CSV.read(Downloads.download(url), DataFrame, delim=',',missingstring="x")
end

"""                                                                                    
    get_pheno(group::String,trait::String="geno";gn_url::String=gn_url())

Returns a given `trait` in a `group`.
"""
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
# increase timeout response from the server
    downloader = Downloads.Downloader();
    downloader.easy_hook = (easy, info) -> Downloads.Curl.setopt(easy, Downloads.Curl.CURLOPT_LOW_SPEED_TIME, 300);

    omics_url = gn_url * "sample_data" * "/" * dataset

    return CSV.read(Downloads.download(omics_url; downloader=downloader), DataFrame, delim=',',missingstring="x")
end