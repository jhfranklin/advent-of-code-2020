using AdventOfCode2020

getInput() = split(read(getInputPath(6), String), "\n\n")

function getUniqueQuestions(row)
    questionSet = setdiff(Set(row), Set('\n'))
    return questionSet
end

function getAnsweredByAll(row)
    Qs = getUniqueQuestions(row)
    passengers = split(row, '\n', keepempty=false)
    [intersect!(Qs,Set(pass)) for pass ∈ passengers]
    return Qs
end

part1() = getInput() .|> getUniqueQuestions .|> length |> sum
part2() = getInput() .|> getAnsweredByAll .|> length |> sum

println("part 1:", part1())
println("part 2:", part2())
