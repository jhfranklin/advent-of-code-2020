using AdventOfCode2020

function getinput() 
    inputArray = getInputPath(11) |> readlines .|> collect
    return hcat(inputArray...)
end

function getneighbours(cell, array)
    arraySize = size(array)
    xcells = filter(a->a ∈ 1:arraySize[1],cell[1] .+ [-1 0 1])
    ycells = filter(a->a ∈ 1:arraySize[2],cell[2] .+ [-1 0 1])
    indices = [CartesianIndex(x, y) for x ∈ xcells, y ∈ ycells if CartesianIndex(x,y) != cell]
    return array[indices]
end

function ingrid(cell, arraysize)
    return cell[1] ∈ 1:arraysize[1] && cell[2] ∈ 1:arraysize[2]
end

function getvisible(cell, array)
    arraySize = size(array)
    directions = Dict{Symbol,CartesianIndex{2}}(
        :N => CartesianIndex(-1,0),
        :S => CartesianIndex(1,0),
        :E => CartesianIndex(0,1),
        :W => CartesianIndex(0,-1),
        :NE => CartesianIndex(-1,1),
        :NW => CartesianIndex(-1,-1),
        :SE => CartesianIndex(1,1),
        :SW => CartesianIndex(1,-1)
    )
    visible = Char[]
    for d ∈ keys(directions)
        c = directions[d]
        currentCell = cell
        while true
            currentCell += c
            !ingrid(currentCell, arraySize) && break
            seat = array[currentCell]
            if seat ∈ ['#', 'L'] 
                push!(visible, seat)
                break
            end
        end
    end
    return visible
end


function updatecell(cell, neighbours, emptyRule)
    if cell == 'L'
        if isempty(findall(isequal('#'), neighbours))
            return '#'
        end
    elseif cell == '#'
        if length(findall(isequal('#'), neighbours)) >= emptyRule
            return 'L'
        end
    end
    return cell
end

function nextstep(array, emptyrule, adjacent=true)
    newArray = copy(array)
    indices = CartesianIndices(array)
    for cell in eachindex(indices)
        neighbours = adjacent ? getneighbours(cell, array) : getvisible(cell,array)
        current = array[cell]
        newArray[cell] = updatecell(current, neighbours ,emptyrule)
    end
    return newArray
end

function part1()
    array = getinput()
    stopped = false
    currentStep = 0
    while !stopped
        currentStep += 1
        nextArray = nextstep(array, 4)
        if nextArray == array
            stopped = true
        end
        array = nextArray
    end
    return count(isequal('#'), array)
end

function part2()
    array = getinput()
    stopped = false
    currentStep = 0
    while !stopped
        currentStep += 1
        nextArray = nextstep(array, 5, false)
        if nextArray == array
            stopped = true
        end
        array = nextArray
    end
    return count(isequal('#'), array)
end

println("part 1:", part1())
println("part 2:", part2())