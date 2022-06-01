using GeneNetworkAPI
using Test

include("generate_ref.jl")

@testset "GeneNetworkAPI.jl" begin
    include("gnAPI_tests.jl")
end