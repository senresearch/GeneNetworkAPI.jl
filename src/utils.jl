

"""                                                                                    
make_rectangular(v_arrays::Vector{Vector{T}} where T)

Takes an array of arrays of any type and make it a matrix of `String`.    
Arrays can be of different type and length. To make the data rectangular,     
it uses the `filler` argument, by default `filler` is an empty string.

## Example 1
```julia
julia> myArrayOfArrays = [["A1","A2", "A3"], ["B1", "B2"], ["C1","C2"]];
julia> make_rectangular(test)
3×3 Matrix{String}:
"A1"  "B1"  "C1"
"A2"  "B2"  "C2"
"A3"  ""    ""
``` 
## Example 2
```julia
julia> myArrayOfArrays = [["A1","A2", "A3"], [1, 2], ["C1","C2"]];
julia> make_rectangular(test)
3×3 Matrix{String}:
"A1"  "1"  "C1"
"A2"  "2"  "C2"
"A3"  ""    ""
```
"""
function make_rectangular(v_arrays; filler="")
    v_arrays = copy(v_arrays)
    # maximum length
    v_inc = maximum(length.(v_arrays)) .-length.(v_arrays) 

    idx2fill = findall(v_inc .> 0)
    for i in idx2fill
        v_arrays[i] = vcat(string.(v_arrays[i]), repeat([filler], v_inc[i]))
    end

    return reduce(hcat, v_arrays)
end


"""                                                                                    
    has_error_500(s::String)

Returns `true` if the server encountered an internal error and was 
unable to complete the request, otherwise it returns `false`.
"""
function has_error_500(s::String)
    return occursin("Error: 500", s)
end

