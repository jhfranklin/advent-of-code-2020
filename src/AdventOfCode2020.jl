module AdventOfCode2020

export getInputPath

function getInputPath(day::Int,input=true)
    return joinpath(@__DIR__,"day" * lpad(day,2,"0"), input ? "input.txt" : "sample.txt")
end

end # module
