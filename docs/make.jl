using GeneNetworkAPI
using Documenter

DocMeta.setdocmeta!(GeneNetworkAPI, :DocTestSetup, :(using GeneNetworkAPI); recursive=true)

makedocs(;
    modules=[GeneNetworkAPI],
    authors="Chelsea Trotter <chelsea.xhu@gmail.com> Gregory Farage <gfarage@uthsc.edu> and Saunak Sen <sen@uthsc.edu>",
    repo="https://github.com/senresearch/GeneNetworkAPI.jl/blob/{commit}{path}#{line}",
    sitename="GeneNetworkAPI.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://senresearch.github.io/GeneNetworkAPI.jl",
        assets=String[],
    ),
    pages=[
        "Overview" => "index.md",
        "Functions" => "functions.md"
    ],
)

deploydocs(;
   repo="github.com/senresearch/GeneNetworkAPI.jl",
   devbranch="dev",
)
