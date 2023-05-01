open("day2.txt") do file
    commands = readlines(file)

    results = [3 6 0; 0 3 6; 6 0 3]
    moves = Dict('A'=>1, 'X'=>1, 'B'=>2, 'Y'=>2, 'C'=>3, 'Z'=>3)
    parsedcommands = [[moves[command[1]], moves[command[3]]] for command in commands]
    value = 0

    for command in parsedcommands
        value += results[command...] + command[2]
    end
    
    println("My value for this list of moves is ", value)

    actualmoves = Dict('X'=>0, 'Y'=>3, 'Z'=>6)
    actuallyparsedcommands = [[moves[command[1]], actualmoves[command[3]]] for command in commands]
    actualvalue = 0
    
    for command in actuallyparsedcommands
        result = findfirst(x->x==command[2], results[command[1],:])
        actualvalue += result + command[2]
    end

    println("My value for this corrected list of moves is ", actualvalue)
end