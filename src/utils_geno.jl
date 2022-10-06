
"""                                                                                    
    parse_geno(filename::String)

Function to parse a .geno file, and returns the genotype dataframe.

"""
function parse_geno(filename::String)
    # read the file into lines
    lines = readlines(filename)
    # which lines have # as first character
    firstpound = (x->match(r"^#",x)).( lines ) .!= nothing
    # which lines have @ as first character
    firstat = (x->match(r"^@",x)).( lines ) .!= nothing
    
    # last line of comment
    endcomment = findfirst( diff(firstat .| firstpound) .< 0 )

    geno = CSV.read(filename, DataFrame, header=endcomment+1 , delim='\t')

    return geno                
end

"""                                                                                    
    genofile_location(json_parsed::Dict)

Returns a vector of String containing the location of geno files for a group.

---
    genofile_location(group::String)

Returns a vector of String containing the location of geno files for a group.

"""
function genofile_location(json_parsed::Dict)
    json_keys = keys(json_parsed)
    # check if "genofile" keys exist
    if ["genofile"] ⊈ json_keys
        error("genofile key not found")
    end

    # check number of genofile for a group
    n_genofile = length(json_parsed["genofile"])

    vlocation_genofile = Vector{String}(undef, n_genofile)

    for i in 1:n_genofile
        ["location"] ⊆ keys(json_parsed["genofile"][i]) ?
        vlocation_genofile[i] = json_parsed["genofile"][i]["location"] :
        error("location key not found")
    end
    
    return vlocation_genofile
end

function genofile_location(group::String; gn_url::String=gn_url())
    # parse geno meta
    geno_url = string(gn_url, "genotypes/", "view/", group)
    str_json = get_api(geno_url)
    json_parsed = parse_json(str_json)
    
    genofile_location(json_parsed)
end


"""                                                                                    
    has_genofile_meta(group::String; gn_url::String=gn_url())

Returns `true` if the group's genotype files possesse metadata that may contain 
alternative location of the files.
"""
function has_genofile_meta(group::String; gn_url::String=gn_url())
    geno_url = string(gn_url, "genotypes/", "view/", group)
    str_json = get_api(geno_url)
    return  !(has_error_500(str_json))
end
