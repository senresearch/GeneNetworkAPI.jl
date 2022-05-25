using HTTP
using JSON

function check_gn(url::AbstractString="http://gn.genenetwork.org/api_pre1/")
    ans = HTTP.get(url)
    res = JSON.Parser.parse(String(g))
end

