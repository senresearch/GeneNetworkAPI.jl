# May 29th, 2019
# Author: Chelsea Trotter
# This file contains functions to process the response of gene network API queries. 



using HTTP
# using LazyJSON #using LazyJSON package because JSON package is considerable slower
using DataFrames
using JSON
using DelimitedFiles
using CSV
using BenchmarkTools
# using DataFramesIO


function get_api(url)
    response = HTTP.get(url)
    String(response.body)
end

function parse_json(str)
    return JSON.parse(str)
end

function process_csv_file(input::String; delim=',', comments=false)
    io = IOBuffer(input)
    data = readdlm(io, delim, '\n', comments=comments, comment_char='#')
    #processing extra comments marked with '@'
    skip_count = count_extra_comment_lines(data)
    data = data[skip_count:end,:]
    return data
end


function count_extra_comment_lines(array)
    # TODO: find more elegant solution to remove extra comments starting with '@'
    done = false
    iter = 1
    comment_char = '@'
    while !done && iter<length(array)
        if array[iter, 1][1] == comment_char
            iter += 1
            array[iter, 1][1] = '#'
        else
            done = true
        end
    end
    return iter


end

function json2mat(s::String)
    # TODO: find more elegent solution to handle one JSON entry and multiple JSON entries at the same time. 
    json = JSON.parse(s)
    if typeof(json) == Dict{String, Any}
        # if json only has one entry 
        nrows = 1
        colnames = sort(collect(keys(json)))
    else
        nrows = length(json)
        colnames = sort(collect(keys(json[1])))
    end
    ncols = length(colnames)

    symbols = Array{Symbol}(undef, ncols)
    for i in 1:ncols
        symbols[i] = Symbol(colnames[i])
    end

    mat = Array{Any}(undef, nrows, ncols)
    for i in 1:ncols 
        for j in 1:nrows
            if nrows == 1
                mat[j,i] = get(json, String(colnames[i]), "NA")
            else   
                mat[j,i] = get(json[j], String(colnames[i]), "NA")
            end
        end
    end

    res1 = convert_df(mat, symbols)
    # res2 = convert_df_slow(mat, symbols)
    
end



function convert_df(mat::Array{Any, 2}, symbols::Array{Symbol,1})
    df = DataFrame()
    for i in 1:length(symbols)
        # tying to use meta programming to convert data frame column type from Any to appropriate type such as String or Int
        # note to self: failed because converting any to a string array vs converting any to Int array is different syntax
        # c = i
        # s = symbols[i]
        # println("$c, $(typeof(s))")
        # eval(:(typeof(df[1,c]))).(df[s])
        # convert.(eval(:(typeof(df[1,c]))), df[s])

        # trying to add one column of data at a time. 
        # This method requires previous knowledge about data.
        # df[symbols[i]] = mat[:,i]
        if (typeof(mat[1,i]) == String)
            df[symbols[i]] = String.(mat[:,i])
            # println("converting to string : type: $(typeof(df[symbols[i]]))")
        elseif (typeof(mat[1,i]) == Int64)
            df[symbols[i]] = convert.(Int64, mat[:,i])
        else # default case: leave it be.
            df[symbols[i]] = mat[:,i]
        end        
    end
    return df 
end

function convert_df_slow(mat::Array{Any, 2}, symbols::Array{Symbol,1})
    # trying to convert dataframe data type without previous knowledge about data. 
    df = DataFrame(mat, symbols)
    CSV.write("temp.csv", df)
    newdf = CSV.read("temp.csv")
    rm("temp.csv")
    return newdf
end