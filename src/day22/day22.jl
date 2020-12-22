using AdventOfCode2020

getinput() = readlines(getInputPath(22))

function parseinput(input)
    player1 = input[2:findfirst(isequal(""),input)-1] .|> x -> parse(Int, x)
    player2 = input[findfirst(isequal(""),input)+2:end] .|> x -> parse(Int, x)
    return (player1, player2)
end

function playround!(player1, player2)
    player1TopCard = popfirst!(player1)
    player2TopCard = popfirst!(player2)
    if player1TopCard > player2TopCard
        push!(player1, player1TopCard)
        push!(player1, player2TopCard)
    else
        push!(player2, player2TopCard)
        push!(player2, player1TopCard)
    end
    return (player1, player2)
end

function calculatescore(x)
    n = length(x)
    return sum(x .* collect(reverse(1:n)))
end

(p1, p2) = getinput() |> parseinput

function part1(p1,p2)
    winnerFound = false
    while !winnerFound
        playround!(p1, p2)
        if length(p1) == 0 || length(p2) == 0
            winnerFound = true
        end
    end
    if length(p1) == 0
        return calculatescore(p2)
    else
        return calculatescore(p1)
    end
end