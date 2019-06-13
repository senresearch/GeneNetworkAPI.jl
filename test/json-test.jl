include("../src/api-process.jl")

url = "http://gn2-zach.genenetwork.org/api/v_pre1/species"
respons = get_api(url)
df = json2mat(respons)



# julia> typeof(df[1,1])
# String

# julia> type_var = :(typeof(df[1,1]))
# :(typeof(df[1, 1]))

# julia> eval(type_var)
# String

# julia> eval(type_var).(df[:FullName])