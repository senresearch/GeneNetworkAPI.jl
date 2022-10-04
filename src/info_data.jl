# This file contains the functions to get data from gene network APIs

###################################
# Functions returning information #
###################################
"""
    info_dataset(dataset::String, trait::String=""; gn_url::String = gn_url())

Returns information about a `dataset` (if `trait` is empty), or else a
given `trait` in a specified `dataset`.
"""
function info_dataset(dataset::String, trait::String=""; gn_url::String = gn_url())
    if(length(trait) != 0)
        url = gn_url * "dataset/" * dataset * "/" * trait
    else 
        url = gn_url * "dataset/" * dataset 
    end
    return json2df(get_api(url))
end

"""
    info_pheno(group::String; gn_url::String=gn_url())

Returns the maximum LRS for each `trait` in a `group``.
"""
function info_pheno(group::String; gn_url::String=gn_url())
    url = gn_url * "traits/" * group * "Publish.json"
    return json2df(get_api(url))
end

"""
    info_pheno(group::String, trait::String; gn_url::String=gn_url())

Returns the maximum LRS for each `trait` in a `group`, or
alternatively a probe (use `trait`) in dataset (use `group`).
"""
function info_pheno(group::String, trait::String; gn_url::String=gn_url())
    url = gn_url * "trait/" * group * "/" * trait
    return json2df(get_api(url))
end

