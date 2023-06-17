function calculate_value(results, moves, commands)
    parsed_commands = [[moves[command[1]], moves[command[3]]] for command in commands]
    value = 0

    for command in parsed_commands
        value += results[command...] + command[2]
    end

    return value
end

function calculate_actual_value(results, moves, actual_moves, commands)
    actual_parsed_commands = [[moves[command[1]], actual_moves[command[3]]] for command in commands]
    actual_value = 0

    for command in actual_parsed_commands
        result = findfirst(x -> x == command[2], results[command[1], :])
        actual_value += result + command[2]
    end

    return actual_value
end

function process_file(file_path)
    commands = readlines(file_path)

    results = [3 6 0; 0 3 6; 6 0 3]
    moves = Dict('A' => 1, 'X' => 1, 'B' => 2, 'Y' => 2, 'C' => 3, 'Z' => 3)
    actual_moves = Dict('X' => 0, 'Y' => 3, 'Z' => 6)

    value = calculate_value(results, moves, commands)
    actual_value = calculate_actual_value(results, moves, actual_moves, commands)

    return value, actual_value
end

function print_results(values)
    value, actual_value = values
    println("My value for this list of moves is ", value)
    println("My value for this corrected list of moves is ", actual_value)
end

file_name = "day2.txt"
values = process_file(file_name)
print_results(values)

