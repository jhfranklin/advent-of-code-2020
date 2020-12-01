using AdventOfCode2020
using Base.Iterators

getInput() = [parse(Int,x) for x in vec(importData(1,true))]

function part1()
    input = getInput() 
    return [i*j for (i,j) ∈ product(input,input) if i+j == 2020][1]
end

function part2()
    input = getInput()
    return [i*j*k for (i,j,k) ∈ product(input,input,input) if i+j+k == 2020][1]
end

println("part 1: ", part1())
println("part 2: ", part2())
