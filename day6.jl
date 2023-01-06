open("day6.txt") do file
    lines = readlines(file)
    buffer = lines[1]
    chars = Set(buffer[1:4])
    i = 0
    while length(chars) < 4
        i += 1
        chars = Set(buffer[1+i:4+i])
    end

    println("We need to process ", i + 4, " characters before the first start-of-packet marker.")

    chars = Set(buffer[1:14])
    i = 0
    while length(chars) < 14
        i += 1
        chars = Set(buffer[1+i:14+i])
    end

    println("We need to process ", i + 14, " characters before the first start-of-message marker.")
end