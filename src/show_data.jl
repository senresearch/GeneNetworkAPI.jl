
"""
    show_table(df::DataFrame)

Displays a dataframe in `pretty` mode.
"""
function show_table(df)
    DataFrames.pretty_table(df[:,:], header = names(df))
end
