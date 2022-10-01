
"""
show_list_geno(group::String,...)

Shows the location name of the different geno files of a group,    
and if available some metadata such as strain of the first filial
generation, maternal and paternal strain.
"""
function show_list_geno(group::String; kwargs...)
df = list_geno(group; kwargs...);
DataFrames.pretty_table(df[:,:], header = names(df))
end
