module GeneNetworkAPI

using HTTP, JSON, DataFrames, BenchmarkTools

export check_gn

include("./api_process.jl")    
include("./query.jl")
include("./get_data.jl")

end
