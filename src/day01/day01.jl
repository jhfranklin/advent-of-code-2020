using AdventOfCode2020
using Base.Iterators

getInput() = [parse(Int,x) for x in vec(importData(1,true))]

function part1()
    input = getInput() 
    return [i*j for (i,j) ∈ product(input,input) if i+j == 2020][1]
end

function part2(input)
   input = sort(input)
    for i in input
        for j in input
            j >= (2020 - i) && break
            k = 2020 - (i + j)
            location = searchsortedfirst(input, k)
            input[location] == k && return i*j*k
        end
    end
end

println("part 1: ", part1())
println("part 2: ", part2(getInput()))
