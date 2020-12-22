using AdventOfCode2020

getinput() = getInputPath(22) |> readlines

function parseinput(input)
    player1 = input[2:findfirst(isequal(""),input)-1] .|> x -> parse(Int, x)
    player2 = input[findfirst(isequal(""),input)+2:end] .|> x -> parse(Int, x)
    return (player1, player2)
end

function playround!(decks)
    player1TopCard = popfirst!(decks[1])
    player2TopCard = popfirst!(decks[2])
    if player1TopCard > player2TopCard
        push!(decks[1], player1TopCard)
        push!(decks[1], player2TopCard)
    else
        push!(decks[2], player2TopCard)
        push!(decks[2], player1TopCard)
    end
    return decks
end

function calculatescore(x)
    n = length(x)
    return sum(x .* collect(reverse(1:n)))
end

function part1()
    decks = getinput() |> parseinput
    winnerFound = false
    while !winnerFound
        playround!(decks)
        if length(decks[1]) == 0 || length(decks[2]) == 0
            winnerFound = true
        end
    end
    if length(decks[1]) == 0
        return calculatescore(decks[2])
    else
        return calculatescore(decks[1])
    end
end

println("Part 1: ", part1())

function playround_recursive!(decks)
    player1TopCard = popfirst!(decks[1])
    player2TopCard = popfirst!(decks[2])
    if length(decks[1]) >= player1TopCard && length(decks[2]) >= player2TopCard
        newDecks = (copy(decks[1][1:player1TopCard]),copy(decks[2][1:player2TopCard]))
        roundWinner = playgame!(newDecks)
    else
        roundWinner = player1TopCard > player2TopCard ? 1 : 2
    end
    # round won, move cards
    if roundWinner == 1
        push!(decks[1], player1TopCard)
        push!(decks[1], player2TopCard)
    else
        push!(decks[2], player2TopCard)
        push!(decks[2], player1TopCard)
    end
    return decks
end

function playgame!(decks)
    history = Set{Tuple{Vector{Int},Vector{Int}}}()
    while true
        decks ∈ history && return 1 # if we've seen this before, player 1 wins
        push!(history,(copy(decks[1]), copy(decks[2]))) # add iteration to history
        playround_recursive!(decks)
        if length(decks[1]) == 0 
            return 2
        elseif length(decks[2]) == 0
            return 1
        end
    end
end

function part2()
    decks = getinput() |> parseinput
    winner = playgame!(decks)
    if length(decks[1]) == 0
        return calculatescore(decks[2])
    else
        return calculatescore(decks[1])
    end
end

println("Part 2: ", part2())