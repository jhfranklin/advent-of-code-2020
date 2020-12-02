using AdventOfCode2020

getInput() = vec(importData(2,true,'\n'))

function checkPassword(input::String)
    parsed = split(input,' ')
    minNum = parse(Int,parsed[1][1:findfirst('-',parsed[1])-1])
    maxNum = parse(Int,parsed[1][findfirst('-',parsed[1])+1:end])
    letter = parsed[2][1]
    password = parsed[3]
    numInPassword = length(filter(isequal(letter),collect(password)))
    return (numInPassword >= minNum) & (numInPassword <= maxNum)
end 


function checkPassword2(input::String)
    parsed = split(input,' ')
    minNum = parse(Int,parsed[1][1:findfirst('-',parsed[1])-1])
    maxNum = parse(Int,parsed[1][findfirst('-',parsed[1])+1:end])
    letter = parsed[2][1]
    password = parsed[3]
    return (password[minNum] == letter) ⊻ (password[maxNum] == letter)
end 

part1(input) = sum([checkPassword(x) for x in input])
part2(input) = sum([checkPassword2(x) for x in input])
