##############################
# GeneNetwork server functions
##############################

"""
    gn_url()

Return the default GeneNetwork server API URL.

All user-level functions optionally take a GeneNetwork server URL that
could be different from the standard URL in case one wanted to query a
different instance of the server.

# Example

```jldoctest
julia> gn_url()
"https://gn2.genenetwork.org/api/v_pre1/"
```
"""
function gn_url()
    return url = "http://gn2.genenetwork.org/api/v_pre1/"
end

"""
    check_gn(url::AbstractString)

Check if GeneNetwork server is responding properly.

Returns the HTTP status code (`200` if successful) and prints a
message.

# Example
```jldoctest
julia> check_gn()
GeneNetwork is alive.
200
```
"""
function check_gn(url::AbstractString=gn_url())
    status = HTTP.get(url).status
    if(status==200)
        println("GeneNetwork is alive.")
    else
        println("Not successful.")
    end
    return status
end

