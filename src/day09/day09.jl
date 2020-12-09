using AdventOfCode2020

getInput() = parse.(Int,readlines(getInputPath(9)))

function checksumwindow(input,windowSize=25)
    N = length(input)
    currentNumber = 0
    for i ∈ (windowSize+1):N
        window = input[i-25:i-1]
        currentNumber = input[i]
        searchList = currentNumber .- window
        !any([x ∈ window for x ∈ searchList]) && return currentNumber
    end
end

function findset(input,numtosearch)
    N = length(input)
    for i ∈ 1:N, j ∈ (i+1):N
        window = input[i:j]
        sum(window) == numtosearch && return maximum(window) + minimum(window)
    end
end
