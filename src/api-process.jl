# May 29th, 2019
# Author: Chelsea Trotter
# This file contains functions to process the response of gene network API queries. 

using HTTP
using DataFrames
using JSON
using BenchmarkTools


function get_api(url)
    response = HTTP.get(url)
    String(response.body)
end

function parse_json(str)
    return JSON.parse(str)
end

function str2df(input::String; delim=',', comments=false)
    df = DataFrames.inlinetable(input, separator=delim, header=true, allowcomments=comments)
end

function json2mat(s::String)
    dict = JSON.parse(s)
    return j2m(dict)
end

# convert an array of json entries to df
function j2m(input::Array{Any,1})
    return vcat(DataFrame.(input)..., cols=:union)
end

# convert a single json entry to df
function j2m(input::Dict{String,Any})
    return DataFrame(input)
end
