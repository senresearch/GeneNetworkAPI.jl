# function to parse a .geno file

function parse_geno(filename::String)
    # read the file into lines
    lines = readlines(filename)
    # which lines have # as first character
    firstpound = (x->match(r"^#",x)).( lines ) .|> !isnothing
    numpound = findfirst( diff( firstpound ) .< 0 )

    # which lines have @ as first character
    firstat = (x->match(r"^@",x)).( lines ) .|> !isnothing
    numat = sum( firstat )

    geno = CSV.read(filename,DataFrame,header=numpound+numat+1,delim='\t')
    return geno                
end
