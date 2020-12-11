using AdventOfCode2020

function getinput() 
    inputArray = getInputPath(11) |> readlines .|> collect
    return hcat(inputArray...)
end

function getneighbours(cell, arraySize)
    xcells = filter(a->a ∈ 1:arraySize[1],cell[1] .+ [-1 0 1])
    ycells = filter(a->a ∈ 1:arraySize[2],cell[2] .+ [-1 0 1])
    return [CartesianIndex(x, y) for x ∈ xcells, y ∈ ycells if CartesianIndex(x,y) != cell]
end

function updatecell(cell, neighbours)
    # If a seat is empty (L) and there are no occupied seats adjacent to it, the seat becomes occupied.
    # If a seat is occupied (#) and four or more seats adjacent to it are also occupied, the seat becomes empty.
    # Otherwise, the seat's state does not change.
    if cell == 'L'
        if isempty(findall(isequal('#'), neighbours))
            return '#'
        end
    elseif cell == '#'
        if length(findall(isequal('#'), neighbours)) >= 4
            return 'L'
        end
    end
    return cell
end

function nextstep(array)
    newArray = copy(array)
    arraySize = size(array)
    indices = CartesianIndices(array)
    for cell in eachindex(indices)
        neighbourhood = getneighbours(cell, arraySize)
        current = array[cell]
        neighbours = array[neighbourhood]
        newArray[cell] = updatecell(current, neighbours)
    end
    return newArray
end

function part1()
    array = getinput()
    stopped = false
    currentStep = 0
    while !stopped
        currentStep += 1
        nextArray = nextstep(array)
        if nextArray == array
            stopped = true
        end
        array = nextArray
    end
    return count(isequal('#'), array)
end

@time part1()