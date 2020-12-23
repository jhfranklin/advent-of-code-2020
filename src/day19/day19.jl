using AdventOfCode2020

getinput() = readlines(getInputPath(19))

function splitinput(rawInput)
    gapLine = findfirst(isequal(""), rawInput)
    rules = rawInput[1:gapLine-1]
    messages = rawInput[gapLine+1:end]
    return (rules, messages)
end

function findunitproductions(rules)
    unitProductions = Dict{String,Vector{String}}()
    for (k, v) ∈ rules
        for p ∈ v
            if length(p) == 1 && tryparse(Int, p[1]) !== nothing
                x = get(unitProductions, k, Vector{String}())
                unitProductions[k] = push!(x, p[1])
            end
        end
    end
    return unitProductions
end

function removeunitproductions!(rules)
    unitProductions = findunitproductions(rules)
    for (A, p) ∈ unitProductions
        for B ∈ p
            productionsToAdd = get(rules, B, Vector{Vector{String}}())
            currentProductions = rules[A]
            filter!(!isequal([B]),currentProductions) # remove unit production
            rules[A] = append!(currentProductions, productionsToAdd) # add rules
        end
    end
    return rules
end

function parserules(rawRules)
    rules = Dict{String,Vector{Vector{String}}}()
    rx = r"(\d+): (.*)"
    for row in rawRules
        m = match(rx, row)
        f = m.captures[1]
        t = m.captures[2] |> (x -> split(x, '|')) .|> strip
        rules[f] = [split(x, ' ') .|> (i -> replace(i,"\""=>""))  for x in t]
    end
    return rules
end

function partitionrules(rules)
    terminalRules = Dict{String,Vector{Vector{String}}}()
    nonTerminalRules = Dict{String,Vector{Vector{String}}}()
    for (A, v) ∈ rules
        for B ∈ v
            if length(B) == 1 # terminal rule
                current = get(terminalRules, A, Vector{Vector{String}}())
                terminalRules[A] = push!(current, B)
            else
                current = get(nonTerminalRules, A, Vector{Vector{String}}())
                nonTerminalRules[A] = push!(current, B)
            end
        end
    end
    return (terminalRules, nonTerminalRules)
end



function CYK(message, grammar)
    n = length(message)
    P = [[Set{String}() for x in 1:n] for y in 1:n]
    # terminals
    for s ∈ 1:n
        for (R,v) ∈ grammar[1]
            for a ∈ v
                if a[1] == string(message[s])
                    push!(P[1][s], R)
                end
            end
        end
    end
    for l ∈ 2:n
        for s ∈ 1:(n-l+1)
            for p ∈ 1:(l-1)
                for (R, v) ∈ grammar[2]
                    for nt ∈ v
                        b = nt[1]
                        c = nt[2]
                        if b ∈ P[p][s] && c ∈ P[l-p][s+p]
                            push!(P[l][s], R)
                        end 
                    end
                end
            end
        end
    end
    return "0" ∈ P[n][1]
end

function part1()
    (rawRules, messages) = splitinput(getinput())
    rules = parserules(rawRules) |> removeunitproductions! |> partitionrules
    rule0(x) = CYK(x,rules)
    cnt = 0
    for m ∈ messages
        if rule0(m)
            cnt += 1
        end
    end
    return cnt
end

part1()