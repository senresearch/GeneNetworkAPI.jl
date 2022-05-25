module GeneNetworkAPI

using HTTP, JSON, DataFrames, CSV, BenchmarkTools

export check_gn,
    list_species,
    list_groups,
    list_datasets,
    info_dataset,
    info_pheno,
    get_geno,
    get_pheno,
    run_gemma,
    run_rqtl,
    run_correlation


include("./api_process.jl")    
include("./query.jl")
include("./get_data.jl")

end
