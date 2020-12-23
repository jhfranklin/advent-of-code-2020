#rawInput = "389125467"
rawInput = "853192647"

input = [parse(Int, x) for x in rawInput]

mutable struct Cup
    label::Int
    next::Cup
    prev::Cup

    function Cup(label)
        x = new()
        x.label = label
        x.prev = x
        x.next = x
        return x
    end

    Cup(label,next,prev) = new(label,next,prev)
end

next(cup::Cup) = cup.next
prev(cup::Cup) = cup.prev

function createcuplist(input)
    cups = [Cup(x) for x in input]
    for (i,cup) in enumerate(cups)
        if i == 1
            cup.next = cups[2]
            cup.prev = cups[end]
        elseif i == length(cups)
            cup.next = cups[1]
            cup.prev = cups[end-1]
        else
            cup.next = cups[i+1]
            cup.prev = cups[i-1]
        end
    end
    return cups
end

function createcuplist(input,maxCupLabel)
    cups = createcuplist(input)
    firstCup = cups[1]
    previousCup = cups[end]
    nextCupLabel = maximum(input) + 1
    for i = nextCupLabel:maxCupLabel
        newCup = Cup(i, cups[1], cups[end])
        cups[end].next = newCup
        push!(cups, newCup)
    end
    firstCup.prev = cups[end]
    previousCup.next = cups[nextCupLabel]
    return cups
end

function getnextcups(currentCup)
    # gets next three cups
    nextCups = Vector{Cup}(undef,3)
    nextCups[1] = currentCup.next
    nextCups[2] = nextCups[1].next
    nextCups[3] = nextCups[2].next
    return nextCups
end

const EMPTY_CUP = Cup(0)

function move!(currentCup, numCups)
    # pick up three cups and relink main list
    nextCups = getnextcups(currentCup)
    currentCup.next = nextCups[end].next
    nextCups[end].next.prev = currentCup
    # find destination cup
    currentCupLabel = currentCup.label
    destinationCupLabel = mod1(currentCupLabel - 1, numCups)
    nextCupToTest = currentCup.next
    destinationCup = EMPTY_CUP
    while true
        if nextCupToTest == currentCup || nextCupToTest ∈ nextCups
            destinationCupLabel = mod1(destinationCupLabel - 1, numCups)
        elseif nextCupToTest.label == destinationCupLabel
            destinationCup = nextCupToTest
            break
        end
        nextCupToTest = nextCupToTest.next
    end
    # place cups
    destinationCup.next.prev = nextCups[end]
    nextCups[end].next = destinationCup.next
    destinationCup.next = nextCups[1]
    nextCups[1].prev = destinationCup
    return currentCup = currentCup.next
end

function part1(input)
    cups = createcuplist(input)
    currentCup = cups[1]
    numCups = length(input)
    for i = 1:100
        currentCup = move!(currentCup, numCups)
    end
    output = ""
    while true
        labelToSearch = 1
        if currentCup.label == labelToSearch
            for i = 1:8
                currentCup = currentCup.next
                output *= string(currentCup.label)
            end
            return output
        end
        currentCup = currentCup.next
    end
end

function part2(input)
    cups = createcuplist(input,1_000_000)
    currentCup = cups[1]
    for i = 1:10_000_000
        currentCup = move!(currentCup, 10_000_000)
    end
    while true
        labelToSearch = 1
        if currentCup.label == labelToSearch
            return (currentCup.next.label * currentCup.next.next.label)
        end
        currentCup = currentCup.next
    end
end

part1(input)
#part2(input)