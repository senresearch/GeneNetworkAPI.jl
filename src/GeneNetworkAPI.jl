module GeneNetworkAPI

    using HTTP, JSON, DataFrames, CSV, Downloads

    include("./api_process.jl")    

    include("./query.jl")
    export gn_url, check_gn

    include("./list_data.jl")
    export list_species, list_groups, list_datasets, list_geno

    include("./info_data.jl")
    export info_dataset, info_pheno

    include("./download_data.jl")
    export download_geno, download_pheno, download_omics

    include("./get_data.jl")
    export get_geno, get_pheno, get_omics

    include("./run_data.jl")
    export run_gemma, run_rqtl, run_correlation

    include("./show_data.jl")
    export show_table

    include("./utils_geno.jl")
    export parse_geno, genofile_location, has_genofile_meta

    include("./utils.jl")
    export make_rectangular, has_error_500

end
