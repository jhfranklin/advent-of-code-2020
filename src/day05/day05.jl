using AdventOfCode2020

getInput() = readlines(getInputPath(5))

function convert(x)
    bin = Dict{Char,Char}('R'=>'1','L'=>'0','F'=>'0','B'=>'1')
    rowString = x[1:end-3]
    colString = x[end-2:end]
    rowBin = join([bin[i] for i in rowString])
    colBin = join([bin[i] for i in colString])
    row = parse(Int,rowBin,base=2)
    col = parse(Int,colBin,base=2)
    return (row*8) + col
end

function part1()
    input = getInput()
    return maximum(convert.(input))
end

function part2()
    input = getInput()
    convertedInput = convert.(input)
    sortedIDs = sort(convertedInput)
    diffedIDs = diff(sortedIDs)
    gapLocation = findfirst(isequal(2),diffedIDs)
    return sortedIDs[gapLocation] + 1
end