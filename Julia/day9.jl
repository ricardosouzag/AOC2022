using LinearAlgebra
headstart = [0, 0]
tailpositionstart = [0, 0]

headmanual = Dict{String,Vector{Int}}([
    ["R", [1, 0]],
    ["L", [-1, 0]],
    ["U", [0, 1]],
    ["D", [0, -1]]
])

function translationvector(head::Vector{Int}, tail::Vector{Int})
    return head - tail
end

function movetail(tail::Vector{Int}, head::Vector{Int}, tailpositions::Set{Vector{Int}})
    translation = translationvector(head, tail)
    if norm(translation, Inf) ≤ 1
        newtail = tail
        push!(tailpositions, newtail)
        return newtail
    end
    if norm(translation, -Inf) == 0
        newtail = tail + translation .÷ 2
        push!(tailpositions, newtail)
        return newtail
    end
    newtail = tail + [coord ÷ abs(coord) for coord in translation]
    push!(tailpositions, newtail)
    return newtail
end

function movehead(head::Vector{Int}, direction::String)
    return head + headmanual[direction]
end

function domove(command::Vector{String}, head::Vector{Int}, tail::Vector{Int}, tailpositions::Set{Vector{Int}})
    dir, amt = command
    amount = parse(Int, amt)
    newhead = movehead(head, dir)
    newtail = movetail(tail, newhead, tailpositions)
    if amount == 1
        return newhead, newtail, tailpositions
    end
    amt = string(amount - 1)
    return domove([dir, amt], newhead, newtail, tailpositions)
end

function domove(commands::Vector{Vector{String}}, head::Vector{Int}=[0, 0], tail::Vector{Int}=[0, 0], tailpositions::Set{Vector{Int}}=Set{Vector{Int}}())
    if commands == []
        return tailpositions
    end
    command, commands = Iterators.peel(commands)
    commands = collect(commands)
    newhead, newtail, tailpositions = domove(command, head, tail, tailpositions)
    return domove(commands, newhead, newtail, tailpositions)
end

function movetails(tails::Vector{Vector{Int}}, lasttail::Vector{Int}, tailpositions::Set{Vector{Int}}, newtails::Vector{Vector{Int}}=Vector{Vector{Int}}())
    if isempty(newtails)
        newtail = popfirst!(tails)
        nexttail = movetail(newtail, lasttail, Set{Vector{Int}}())
        push!(newtails, nexttail)
        return movetails(tails, nexttail, tailpositions, newtails)
    end
    if isempty(tails)
        push!(tailpositions, lasttail)
        return newtails
    end
    x, xs = Iterators.peel(tails)
    nexttail = movetail(x, lasttail, Set{Vector{Int}}())
    push!(newtails, nexttail)
    return movetails(collect(xs), nexttail, tailpositions, newtails)
end

function domovebeegrope(command::Vector{String}, head::Vector{Int}, tails::Vector{Vector{Int}}, tailpositions::Set{Vector{Int}})
    dir, amt = command
    amount = parse(Int, amt)
    newhead = movehead(head, dir)
    newtails = movetails(tails, newhead, tailpositions)
    if amount == 1
        return newhead, newtails, tailpositions
    end
    amt = string(amount - 1)
    return domovebeegrope([dir, amt], newhead, newtails, tailpositions)
end

function domovebeegrope(commands::Vector{Vector{String}}, head::Vector{Int}=[0, 0], tails::Vector{Vector{Int}}=repeat([[0, 0]], 9), tailpositions::Set{Vector{Int}}=Set{Vector{Int}}())
    if commands == []
        return tailpositions
    end
    command, commands = Iterators.peel(commands)
    commands = collect(commands)
    newhead, newtails, tailpositions = domovebeegrope(command, head, tails, tailpositions)
    return domovebeegrope(commands, newhead, newtails, tailpositions)
end

file = open("day9.txt")
lines = readlines(file)
lines = [map(string, line) for line in map(split, lines)]
println("The tail of the 2-units long rope visits ", length(domove(lines)), " unique coordinates at least once.")
println("The tail of the 10-units long rope visits ", length(domovebeegrope(lines)), " unique coordinates at least once.")
close(file)