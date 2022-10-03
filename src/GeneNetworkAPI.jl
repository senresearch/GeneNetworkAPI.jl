module GeneNetworkAPI

    using HTTP, JSON, DataFrames, CSV, Downloads

    include("./api_process.jl")    

    include("./query.jl")
    export gn_url, check_gn

    include("./list_data.jl")
    export list_species, list_groups, list_datasets, list_geno

    include("./info_data.jl")
    export info_dataset, info_pheno

    include("./get_data.jl")
    export get_geno, get_pheno

    include("./run_data.jl")
    export run_gemma, run_rqtl, run_correlation

    include("./show_data.jl")
    export show_list_geno

    include("./utils_geno.jl")
    export parse_geno, genofile_location

    include("./utils.jl")
    export make_rectangular, has_error_500

end
