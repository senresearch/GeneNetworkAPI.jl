using Documenter, GeneNetworkAPI

makedocs(
    sitename="Interface to GeneNetwork REST API",
    modules = "GeneNetworkAPI",
    authors = "Chelsea Trotter, Gregory Farage, and Saunak Sen",
    clean = true,
    debug = true,
    pages = [
        "Overview" => "index.md"]
    
)

deploydocs(
    repo = "github.com/senresearch/GeneNetworkAPI.jl.git"
)
