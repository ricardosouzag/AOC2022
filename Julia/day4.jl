open("day4.txt") do file
    lines = readlines(file)
    sectors = [split(line, [',', '-']) for line in lines]
    sectors = [[tryparse(Int, string(char)) for char in line] for line in sectors]
    sectors = [[line[1] line[2]; line[3] line[4]] for line in sectors]
    overlaps = [((line[1,1] ≤ line[2,1]) & (line[1,2] ≥ line[2,2])) |
                ((line[1,1] ≥ line[2,1]) & (line[1,2] ≤ line[2,2])) for line in sectors]
    println("One range fully contains the other in ", sum(overlaps), " assignment pairs.")

    totaloverlaps = [(line[2,1] ≤ line[1,1]) & (line[1,1] ≤ line[2,2]) |
                     (line[1,1] ≤ line[2,1]) & (line[2,1] ≤ line[1,2]) for line in sectors]

    println("One range overlaps another in ", sum(totaloverlaps), " assignment pairs.")
end