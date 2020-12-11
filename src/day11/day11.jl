using AdventOfCode2020

function getinput() 
    inputArray = getInputPath(11) |> readlines .|> collect
    return hcat(inputArray...)
end

function getneighbours(cell, indices)
    xcells = cell[1] .+ [-1 0 1]
    ycells = cell[2] .+ [-1 0 1]
    neighbourhood = [CartesianIndex(x, y) for x ∈ xcells, y ∈ ycells if CartesianIndex(x,y) != cell]
    return intersect(neighbourhood, indices)
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
    indices = CartesianIndices(array)
    for cell in eachindex(indices)
        neighbourhood = getneighbours(cell, indices)
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
        println(currentStep)
        nextArray = nextstep(array)
        if nextArray == array
            stopped = true
        end
        array = nextArray
    end
    return count(isequal('#'), array)
end

@time part1()