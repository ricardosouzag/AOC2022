function calculate_priority(value, items)
    return sum(value[item...] for item in items)
end

function generate_inventory(lines)
    return [[line[begin:1:length(line)÷2], line[length(line)÷2+1:1:end]] for line in lines]
end

function calculate_mistakes(inventory)
    return [intersect(bag[1], bag[2]) for bag in inventory]
end

function group_lines(lines)
    return [lines[i:1:i+2] for i in range(1, length(lines), step=3)]
end

function calculate_badges(groups)
    return [intersect(elves...) for elves in groups]
end

function process_file(file_path)
    lines = readlines(file_path)
    
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
        'Z' => 52,
        )
    
    inventory = generate_inventory(lines)
    mistakes = calculate_mistakes(inventory)
    rucksack_priority = calculate_priority(value, mistakes)
    
    groups = group_lines(lines)
    badges = calculate_badges(groups)
    badges_priority = calculate_priority(value, badges)
    
    return rucksack_priority, badges_priority
end

function print_results(priorities)
    rucksack_priority, badges_priority = priorities
    
    println("The sum of the priorities of the repeated items in the rucksack is ", rucksack_priority)
    
    println("The sum of the priorities of the badges of each group is ", badges_priority)
end

file_path = "day3.txt"
(print_results ∘ process_file)(file_path)
