open("day1.txt") do file
    lines = readlines(file)
    top3 = [0,0,0]
    currcal = 0
    
    for line in lines
        if tryparse(Int, line) !== nothing
            currcal += parse(Int, line)
        end
        if line == "" || line === last(lines)
            if currcal > top3[3]
                pop!(top3)
                push!(top3, currcal)
                sort!(top3, rev = true)
            end
            currcal = 0
        end
    end

    println("The elf carrying the most calories is carrying ", top3[1], " calories.")
    println("The three elves carrying the most calories carry together ", sum(top3), " calories.")
end