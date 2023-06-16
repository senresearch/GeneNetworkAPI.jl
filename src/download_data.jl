# This file contains the functions to download data from gene network APIs

##############################
# Functions downloading data #
##############################

#############
# Geno data #
#############
"""                                                                                    
    download_geno(group::String,format::String="geno";
                    gn_url::String=gn_url(),
                    path::String = "")

Download the genotype matrix for a `group` in a given `format`.

Currently works only for files in the `geno` format.

The file will be downloaded in `path` location, if  `path` is not specified, then 
the file will be a temporary file.

"""
function download_geno(group, format = "geno";
                        gn_url::String = gn_url(),
                        path::String = tempname())

	if has_genofile_meta(group; gn_url = gn_url)
		# need to check real location of data
		vlocation = genofile_location(group; gn_url = gn_url)

		if length(vlocation) == 1
			group = vlocation[1][1:end-5] # expect ".geno" extension
			# else
			# println("Info: group ", group, " has additional genotype files, see locations")
			# show_table(list_geno(group; gn_url=gn_url))
		end
	end

	# increase timeout response from the server
	downloader = Downloads.Downloader()
	downloader.easy_hook = (easy, info) -> Downloads.Curl.setopt(easy, Downloads.Curl.CURLOPT_LOW_SPEED_TIME, 300)

	geno_url = gn_url * "genotypes/" * group * "." * format

	return Downloads.download(geno_url, path; downloader = downloader)
end

##############
# Pheno data #
##############

"""                                                                                    
    download_pheno(dataset::String;gn_url::String=gn_url())

Downloads the non-omic ("clinical") phenotypes for a given `dataset`.
The file will be downloaded in `path` location, if  `path` is not specified, then 
the file will be a temporary file.
"""
function download_pheno(dataset::String; 
                        gn_url::String=gn_url(),
                        path::String = tempname())
    pheno_url = gn_url * "sample_data" * "/" * dataset * "Publish"
    return Downloads.download(pheno_url, path)
end

##############
# Omics data #
##############


"""                                                                                    
    download_omics(dataset::String; 
                    gn_url::String=gn_url(), 
                    path::String = tempname())

Download the omic phenotypes for a given `dataset`.
The file will be downloaded in `path` location, if  `path` is not specified, then 
the file will be a temporary file.
"""
function download_omics(dataset::String; 
                        gn_url::String=gn_url(), 
                        path::String = tempname())
# increase timeout response from the server
    downloader = Downloads.Downloader();
    downloader.easy_hook = (easy, info) -> Downloads.Curl.setopt(easy, Downloads.Curl.CURLOPT_LOW_SPEED_TIME, 300);

    omics_url = gn_url * "sample_data" * "/" * dataset

    return Downloads.download(omics_url, path; downloader=downloader)
end