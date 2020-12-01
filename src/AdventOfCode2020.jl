module AdventOfCode2020

using DelimitedFiles

export importData

function importData(day::Int, delimIndicator::Bool = false, delim::Char = ',')
    path = joinpath(@__DIR__,"day" * lpad(day,2,"0"), "input.txt")
    if delimIndicator
        return readdlm(path, delim, String)
    else
        s = open(path) do file
            read(file, String)
        end
        return s
    end
end

end # module
