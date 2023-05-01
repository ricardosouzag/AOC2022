open("day3.txt") do file
    lines = readlines(file)
    value = Dict(
        'a' => 1,
        'b' => 2,
        'c' => 3,
        'd' => 4,
        'e' => 5,
        'f' => 6,
        'g' => 7,
        'h' => 8,
        'i' => 9,
        'j' => 10,
        'k' => 11,
        'l' => 12,
        'm' => 13,
        'n' => 14,
        'o' => 15,
        'p' => 16,
        'q' => 17,
        'r' => 18,
        's' => 19,
        't' => 20,
        'u' => 21,
        'v' => 22,
        'w' => 23,
        'x' => 24,
        'y' => 25,
        'z' => 26,
        'A' => 27,
        'B' => 28,
        'C' => 29,
        'D' => 30,
        'E' => 31,
        'F' => 32,
        'G' => 33,
        'H' => 34,
        'I' => 35,
        'J' => 36,
        'K' => 37,
        'L' => 38,
        'M' => 39,
        'N' => 40,
        'O' => 41,
        'P' => 42,
        'Q' => 43,
        'R' => 44,
        'S' => 45,
        'T' => 46,
        'U' => 47,
        'V' => 48,
        'W' => 49,
        'X' => 50,
        'Y' => 51,
        'Z' => 52)
    inventory = [[line[begin:1:length(line)÷2], line[length(line)÷2+1:1:end]] for line in lines]
    mistakes = [intersect(bag[1], bag[2]) for bag in inventory]

    rucksackpriority = sum([value[item...] for item in mistakes])
    println("The sum of the priorities of the repeated items in the rucksack is ", rucksackpriority)

    groups = [lines[i:1:i+2] for i in range(1,length(lines), step=3)]
    badges = [intersect(elves...) for elves in groups]
    badgespriority = sum([value[badge...] for badge in badges])
    println("The sum of the priorities of the badges of each group is ", badgespriority)
end