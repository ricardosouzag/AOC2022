# Function to process individual commands in the input string
function parsecmd(cmd::String, cycle::Int, reg::Int, strs::Vector{Int}, skip::Bool=false)
    newcycle = cycle + 1
    newreg = reg
    newcmd = split(cmd)  # Split the command into individual parts
    if length(newcmd) > 1
        if !skip
            push!(strs, signalstr(newcycle, newreg))  # Push the signal strength into the vector
            return parsecmd(cmd, newcycle, newreg, strs, true)
        end
        push!(strs, signalstr(newcycle, newreg))  # Push the signal strength into the vector
        newreg = reg + parse(Int, newcmd[2])  # Update the register value by parsing the second part of the command
        return newcycle, newreg
    end
    push!(strs, signalstr(newcycle, newreg))  # Push the signal strength into the vector
    return newcycle, newreg
end

# Function to calculate the signal strength based on the cycle and register values
function signalstr(cycle::Int, reg::Int)
    return cycle * reg
end

# Function to process the list of commands and generate a vector of signal strengths
function signalstr(commands::Vector{String})
    strs = Vector{Int}()
    cycle = 0
    reg = 1
    for cmd in commands
        cycle, reg = parsecmd(cmd, cycle, reg, strs)
    end
    return strs
end

# Function to calculate the sum of signal strengths at specific cycles
function calculate_sum(signaldict::Vector{Int}, start::Int, step::Int, count::Int)
    return sum(signaldict[start:step:start+step*(count-1)])
end

# Read the lines from the input file
lines = readlines("day10.txt")

# Generate the dictionary of signal strengths based on the input commands
signaldict = signalstr(lines)

# Calculate the sum of signal strengths at specific cycles
sum_of_signals = calculate_sum(signaldict, 20, 40, 6)

# Print the result
println("The sum of signal strength at cycles 20, 60, 100, 140, 180, and 220 is ", sum_of_signals)
