using GeneNetworkAPI
using Documenter

DocMeta.setdocmeta!(GeneNetworkAPI, :DocTestSetup, :(using GeneNetworkAPI); recursive=true)

makedocs(
    modules=[GeneNetworkAPI],
    sitename="GeneNetworkAPI.jl",
    pages=[
        "Overview" => "index.md",
        "Functions" => "functions.md"
    ],
)

deploydocs(;
   repo="https://github.com/senresearch/GeneNetworkAPI.jl",
   devbranch="dev",
)
