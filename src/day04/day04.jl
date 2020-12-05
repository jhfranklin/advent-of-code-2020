using AdventOfCode2020

getInput() = readlines(getInputPath(4))

function part1()
    requiredFields = ["byr","iyr","eyr","hgt","hcl","ecl","pid"]
    input = getInput()
    push!(input,"")
    currentData = ""
    validPasswords = 0
    for row in input
        if row == ""
            # check
            inData = [occursin(x,currentData) for x in requiredFields]
            all(inData) && (validPasswords+=1)
            currentData=""
        else 
            currentData *= ""
            currentData *= row
        end
    end
    return validPasswords
end

function checkPassportIsValid(data)
    fields = Dict{String,String}()
    requiredFields = ["byr","iyr","eyr","hgt","hcl","ecl","pid"]
    for f in requiredFields
        locateField = findfirst(f*":",data)[end]
        locateEndOfField = findnext(' ',data,locateField)
        isnothing(locateEndOfField) && (locateEndOfField = length(data) + 1)
        fields[f] = data[locateField+1:locateEndOfField-1]
    end
    # tests
    passwordValid = true
    for key in keys(fields)
        if key == "byr"
            yr = tryparse(Int,fields[key])
            if isnothing(yr) || !(yr >= 1920 && yr <= 2002)
                passwordValid = false
                break
            end
        elseif key == "iyr"
            yr = tryparse(Int,fields[key])
            if isnothing(yr) || !(yr >= 2010 && yr <= 2020)
                passwordValid = false
                break
            end
        elseif key == "eyr"
            yr = tryparse(Int,fields[key])
            if isnothing(yr) || !(yr >= 2020 && yr <= 2030)
                passwordValid = false
                break
            end
        elseif key == "hgt"
            system = fields[key][end-1:end]
            height = tryparse(Int,fields[key][1:end-2])
            if isnothing(height)
                passwordValid = false
                break
            elseif system == "cm"
                if !(height in 150:193)
                    passwordValid = false
                    break
                end
            elseif system == "in"
                if !(height in 59:76)
                    passwordValid = false
                    break
                end
            else
                passwordValid = false
                break
            end
        elseif key == "hcl"
            hcl = fields[key]
            if !(hcl[1] == '#' && (length(hcl) == 7))
                passwordValid = false
                break
            end
            col = collect(hcl[2:end])
            validCol = ['a' 'b' 'c' 'd' 'e' 'f' '0' '1' '2' '3' '4' '5' '6' '7' '8' '9']
            validChar = [c in validCol for c in col]
            if !all(validChar)
                passwordValid = false
                break
            end
        elseif key == "ecl"
            validEyes = ["amb" "blu" "brn" "gry" "grn" "hzl"  "oth"]
            if !(fields[key] in validEyes)
                passwordValid = false
                break
            end
        elseif key == "pid"
            pid = fields[key]
            numDigits = length(pid)
            num = tryparse(Int,pid)
            if numDigits != 9 || isnothing(num)
                passwordValid = false
                break
            end
        end
    end
    return passwordValid
end

function part2()
    requiredFields = ["byr","iyr","eyr","hgt","hcl","ecl","pid"]
    input = getInput()
    push!(input,"")
    currentData = ""
    validPasswords = 0
    for row in input
        if row == ""
            # check
            inData = [occursin(x*":",currentData) for x in requiredFields]
            all(inData) && checkPassportIsValid(currentData) && (validPasswords+=1)
            currentData=""
        else 
            currentData *= " "
            currentData *= row
        end
    end
    return validPasswords
end
