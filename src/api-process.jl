# May 29th, 2019
# Author: Chelsea Trotter
# This file contains functions to process the response of gene network API queries. 



using HTTP
using LazyJSON #using LazyJSON package because JSON package is considerable slower

# using DataFramesIO


function get_api(url)
    response = HTTP.get(url)
    String(response.body)
end

function parse_json(str)
    return LazyJSON.parse(str)
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
    done = false
    iter = 1
    comment_char = '@'
    while !done 
        if array[iter, 1][1] == comment_char
            iter += 1
        else
            done = true
        end
    end
    return iter
end


