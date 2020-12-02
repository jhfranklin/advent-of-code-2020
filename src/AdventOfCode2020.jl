module AdventOfCode2020

export getInputPath

function getInputPath(day::Int)
    return joinpath(@__DIR__,"day" * lpad(day,2,"0"), "input.txt")
end

end # module
