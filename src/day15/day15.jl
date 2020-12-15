input = "6,19,0,5,7,13,1"

function parseinput(x)
    return parse.(Int, split(x,','))
end

function part1(input)
    numbers = parseinput(input)
    numberDict = Dict{Int, Tuple{Int,Int}}()
    # init number dict
    for (i, num) ∈ enumerate(numbers)
        numberDict[num] = (i, i)
    end
    lastNumberSpoken = numbers[end]
    currentIndex = length(numbers) + 1
    for i ∈ currentIndex:2020
        turns = get(numberDict, lastNumberSpoken, nothing)
        lastNumberSpoken = turns[2] - turns[1]
        if haskey(numberDict, lastNumberSpoken)
            previous = numberDict[lastNumberSpoken]
            numberDict[lastNumberSpoken] = (previous[2], i)
        else
            numberDict[lastNumberSpoken] = (i, i)
        end
    end
    return lastNumberSpoken
end

function part2(input)
    numbers = parseinput(input)
    numberDict = Dict{Int, Tuple{Int,Int}}()
    # init number dict
    for (i, num) ∈ enumerate(numbers)
        numberDict[num] = (i, i)
    end
    lastNumberSpoken = numbers[end]
    currentIndex = length(numbers) + 1
    for i ∈ currentIndex:30000000
        turns = get(numberDict, lastNumberSpoken, nothing)
        lastNumberSpoken = turns[2] - turns[1]
        if haskey(numberDict, lastNumberSpoken)
            previous = numberDict[lastNumberSpoken]
            numberDict[lastNumberSpoken] = (previous[2], i)
        else
            numberDict[lastNumberSpoken] = (i, i)
        end
    end
    return lastNumberSpoken
end

part1(input)
part2(input)