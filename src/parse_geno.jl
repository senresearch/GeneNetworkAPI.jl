
"""                                                                                    
    parse_geno(filename::String)

Function to parse a .geno file, and returns the genotype dataframe.

"""
function parse_geno(filename::String)
    # read the file into lines
    lines = readlines(filename)
    # which lines have # as first character
    firstpound = (x->match(r"^#",x)).( lines ) .!= nothing
    # which lines have @ as first character
    firstat = (x->match(r"^@",x)).( lines ) .!= nothing
    
    # last line of comment
    endcomment = findfirst( diff(firstat .| firstpound) .< 0 )

    geno = CSV.read(filename, DataFrame, header=endcomment+1 , delim='\t')

    return geno                
end
