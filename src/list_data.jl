# This file contains the functions to get data from gene network APIs

############################
# Functions returning list #
############################
"""                                                                                    
    list_species(species::String="";gn_url::String=gn_url())

Returns a data frame with a list of species respresented in the
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
    list_datasets(group::String="";gn_url::String=gn_url())

Lists all datasets available in a specified `group`.
"""
function list_datasets(group::String; gn_url::String=gn_url())
    url = gn_url * "datasets/"  * group
    return json2df(get_api(url))
end

"""
    list_geno(group::String; gn_url::String=gn_url())

Returns a data frame with the location name of the different geno files of 
a group, and if available some metadata such as strain of the first filial
generation, maternal and paternal strain. 
If there exist more than one location, the default location is indicated 
by a `*`. 
"""
function list_geno(group::String; gn_url::String=gn_url())
    # parse geno meta
    geno_url = string(gn_url, "genotypes/", "view/", group)
    str_json = get_api(geno_url)

    if has_error_500(str_json) 
        return println("No metadata or could not parse json page.")
    else
        json_parsed = parse_json(str_json)
    end  

    # check if "genofile" keys exist
    json_keys = keys(json_parsed)
    if ["genofile"] ⊈ json_keys
        error("genofile key not found")
    end

    # get geno meta
    if length(json_keys) > 1
        meta_keys = sort(collect(setdiff(json_keys, ["genofile"])))
        vmeta_geno = Vector{Any}(undef, length(meta_keys))
        for i in 1:lastindex(meta_keys)
            vmeta_geno[i] = typeof(json_parsed[meta_keys[i]]) <: Vector ?
                            json_parsed[meta_keys[i]] :                
                            [json_parsed[meta_keys[i]]]
        end
        vmeta_geno = vcat(vmeta_geno, [genofile_location(json_parsed)])
        dfmeta_geno = DataFrame(make_rectangular(vmeta_geno), vcat(meta_keys, ["location"]))
    else # only location available in metadata
        vmeta_geno = genofile_location(json_parsed)
        dfmeta_geno = DataFrame(location=vmeta_geno)
    end

    if length(dfmeta_geno.location) > 1
        format = ".geno" # expect ".geno" location file
        idx_default = findall(group*format .== dfmeta_geno.location)
        dfmeta_geno[idx_default, :location] .= dfmeta_geno[idx_default, :location] .* "*"
    end

    return dfmeta_geno     
end

