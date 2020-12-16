using AdventOfCode2020

getinput() = readlines(getInputPath(16))

function part1()
    input = getinput()
    # create valid set
    fieldRules = input[1:findfirst(isequal(""),input)-1]
    rx = r"(.*): (\d*)-(\d*) or (\d*)-(\d*)"
    validSet = BitSet()
    for row in fieldRules
        m = match(rx, row)
        group1 = parse(Int, m.captures[2]):parse(Int, m.captures[3])
        group2 = parse(Int, m.captures[4]):parse(Int, m.captures[5])
        union!(validSet, group1)
        union!(validSet, group2)
    end
    # find invalid fields
    otherTickets = input[findfirst(isequal("nearby tickets:"),input)+1:end]
    ticketScanningErrorRate = 0
    for ticket in otherTickets
        values = parse.(Int,split(ticket, ","))
        ticketScanningErrorRate += sum([v for v ∈ values if v ∉ validSet])
    end
    return ticketScanningErrorRate
end

part1()