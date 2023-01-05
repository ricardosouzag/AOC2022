using DataStructures
open("day5.txt") do file
    lines = readlines(file)
    space = findfirst(x -> x == "", lines)
    numberofstacks = maximum([parse(Int, char) for char in lines[space-1] if char != ' '])
    stacks = SortedDict([[i, reverse(foldl(*, [lines[j][2+4*(i-1)] for j in 1:space-2 if lines[j][2+4*(i-1)] != ' ']))] for i in 1:numberofstacks])
    moves = [[char for char in map(x -> tryparse(Int, x), split(move)) if char !== nothing] for move in lines[space+1:end]]

    function doMove(amount, sourcestack, targetstack)
        stacks[targetstack] = string(stacks[targetstack], reverse(stacks[sourcestack][end-amount+1:end]))
        stacks[sourcestack] = stacks[sourcestack][begin:end-amount]
    end

    initialstacks = copy(stacks)

    for move in moves
        doMove(move...)
    end

    top = foldl(*, [v[end] for v in values(stacks)])

    println("The message at the top of the stacks reads ", top)

    function doMove9001(amount, sourcestack, targetstack)
        stacks[targetstack] = string(stacks[targetstack], stacks[sourcestack][end-amount+1:end])
        stacks[sourcestack] = stacks[sourcestack][begin:end-amount]
    end

    stacks = initialstacks

    for move in moves
        doMove9001(move...)
    end

    top = foldl(*, [v[end] for v in values(stacks)])

    println("The actual message at the top of the stacks reads ", top)
end