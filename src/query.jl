using Requests
using JSON

function checkGN(url::AbstractString="http://test-gn2.genenetwork.org/api_pre1/")
    ans = get(url)
    res = JSON.Parser.parse(readall(g))
end

