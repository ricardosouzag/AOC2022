function count_calories(acc, curr_line)
    cal, top_cal, lines = acc

    if tryparse(Int, curr_line) !== nothing
        cal += parse(Int, curr_line)
    end

    if curr_line == "" || curr_line === last(lines)
        if cal > top_cal[3]
            top_cal[end] = cal
            sort!(top_cal, rev = true)
        end
        cal = 0
    end

    return cal, top_cal, lines
end

function process_file(file_name)
    open(file_name) do file
        lines = readlines(file)
        _, top_calories, _ = foldl(count_calories, lines; init=(0, [0, 0, 0], lines))
        return top_calories
    end
end

function print_results(top_calories)
    println("The elf carrying the most calories is carrying ", top_calories[1], " calories.")
    println("The three elves carrying the most calories carry together ", sum(top_calories), " calories.")
end

file_name = "day1.txt"
top_calories = process_file(file_name)
print_results(top_calories)
