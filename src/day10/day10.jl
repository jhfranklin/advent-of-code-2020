using AdventOfCode2020

getInput() = parse.(Int,readlines(getInputPath(10)))

test1 = [16
10
15
5
1
11
7
19
6
12
4]

test2 = [28
33
18
42
31
14
46
20
48
47
24
23
49
45
19
38
39
11
1
32
25
35
8
17
7
9
4
2
34
10
3]

function part1()
    input = test1
    sortedinput = sort(input)
    firstadapter = 1
    prepend!(sortedinput, 0)
    finaladapter = maximum(sortedinput) + 3
    push!(sortedinput, finaladapter)
    println(sortedinput)
    diffedinput = diff(sortedinput)
    println(diffedinput)
    return count(isequal(1),diffedinput) * (count(isequal(3), diffedinput))
end

function getcontiguousones(input::Vector{Int})
    groups = Int[]
    currentgroupsize = 0
    for i ∈ eachindex(input)
        if input[i] == 1
            currentgroupsize += 1
        elseif input[i-1] == 1
            push!(groups, currentgroupsize)
            currentgroupsize = 0
        end
    end
    return groups
end

function waystoorder(x::Int)
    # assumes maximum is 4
    if x == 1
        return 1
    elseif x == 2
        return 2
    elseif x == 3
        return 4
    elseif x == 4
        return 7
    end
end

function part2()
    input = getInput()
    sortedinput = sort(input)
    firstadapter = 1
    prepend!(sortedinput, 0)
    finaladapter = maximum(sortedinput) + 3
    push!(sortedinput, finaladapter)
    diffedinput = diff(sortedinput)
    contigousgroupsofone = getcontiguousones(diffedinput)
    return contigousgroupsofone .|> waystoorder |> prod
end

part1()
part2()

println("part 1:",part1())
println("part 2:",part2())