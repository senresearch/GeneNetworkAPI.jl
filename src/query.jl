function check_gn(url::AbstractString="http://gn2.genenetwork.org/api_pre1/")
    status = HTTP.get(url).status
    if(status==200)
        println("GeneNetwork is alive.")
    else
        println("Not successful.")
    end
    return status
end

