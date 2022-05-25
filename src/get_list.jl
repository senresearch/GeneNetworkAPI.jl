include("./api-process.jl")

function list_species(species="", gn_url=gn_url())
    if (length(species) != 0)
        species_url = gn_url * "species/" * species 
        return parse_json(get_api(species_url))
    else
        species_url = gn_url * "species"
        return parse_json(get_api())
    end
end

