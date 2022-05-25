function check_gn(url::AbstractString="http://gn2.genenetwork.org/api_pre1/")
    res = JSON.Parser.parse(String(body(HTTP.get(url))))
    return res
end

