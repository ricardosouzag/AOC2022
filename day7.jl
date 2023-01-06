using DataStructures
mutable struct Directory
    name::String
    parent::String
    children::Vector{String}
    files::Dict{String,Int}

    Directory() = new("", "", [], Dict())
    Directory(x) = new(x, "", [], Dict())
    Directory(x, y) = new(x, y, [], Dict())
end

function cmdparse(x::String, curr::String)
    cmd = split(x)
    if cmd[1] == "\$"
        curr = runcmd(cmd, curr)
    elseif cmd[1] == "dir"
        push!(dirdict[curr].children, curr * "/" * cmd[2])
    else
        dirdict[curr].files[String(cmd[2])] = parse(Int, cmd[1])
    end
    return curr
end

function cmdparse(xs::Vector{String}, curr::String)
    (x, s) = Iterators.peel(xs)
    return collect(s) == [] ? cmdparse(x, curr) : cmdparse(collect(s), cmdparse(x, curr))
end

function runcmd(command::Vector{SubString{String}}, currdir::String)
    return command[2] == "cd" ? cd(currdir, String(command[3])) : currdir
end

function cd(from::String, to::String)
    if to == ".."
        return dirdict[from].parent
    elseif to == "/"
        dirdict[to] = Directory(to)
        return to
    end
    dirdict[from * "/" * to] = Directory(from * "/" * to, from)
    return from * "/" * to
end

function directorysize(dir::String, acc::Int=0)
    value = acc + sum(values(dirdict[dir].files))
    return dirdict[dir].children == [] ? value : directorysize(dirdict[dir].children, value)
end

function directorysize(dirs::Vector{String}, acc::Int=0)
    (x, xs) = Iterators.peel(dirs)
    return collect(xs) == [] ? directorysize(x, acc) : directorysize(collect(xs), directorysize(x, acc))
end

file = open("day7.txt")
lines = readlines(file)
dirdict = Dict{String,Directory}()

currdir = ""
cmdparse(lines, currdir)
close(file)

sizes = [directorysize(dir) for dir in keys(dirdict)]
smalldirs = [dir for dir in sizes if dir ≤ 100000]
println("The sum of the sizes of the small directories is ", sum(smalldirs))

availablespace = 70000000 - directorysize("/")
requiredspace = 30000000 - availablespace
# equivalently, just set requiredspace = directorysize("/") - 40000000 but that's less clear

bigdirs = [dir for dir in sizes if dir ≥ requiredspace]
println("The smallest directory that could be deleted to allow space for the update has size ", minimum(bigdirs))