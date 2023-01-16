function parsecmd(cmd::String, cycle::Int, reg::Int, strs::Vector{Int}, skip::Bool=false)
    newcycle = cycle + 1
    newreg = reg
    newcmd = split(cmd)
    if length(newcmd) > 1
        if !skip
            push!(strs, signalstr(newcycle, newreg))
            return parsecmd(cmd, newcycle, newreg, strs, true)
        end
        push!(strs, signalstr(newcycle, newreg))
        newreg = reg + parse(Int, newcmd[2])
        return newcycle, newreg
    end
    push!(strs, signalstr(newcycle, newreg))
    return newcycle, newreg
end

function signalstr(cycle::Int, reg::Int)
    return cycle * reg
end

function signalstr(commands::Vector{String}, strs::Vector{Int}=Vector{Int}(), cycle::Int=0, reg::Int=1)
    if isempty(commands)
        return strs
    end
    cmd, cmds = Iterators.peel(commands)
    newcycle, newreg = parsecmd(cmd, cycle, reg, strs)
    return signalstr(collect(cmds), strs, newcycle, newreg)
end
open("day10.txt") do file
    lines = readlines(file)
    signaldict = signalstr(lines)
    println("The sum of signal strength at cycles 20, 60, 100, 140, 180 and 220 is ", sum([signaldict[20+40*i] for i in 0:5]))
end