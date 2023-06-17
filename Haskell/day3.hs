import Data.List (intersect)
import Data.Map (Map, fromList, (!))

-- Calculates the priority of items based on a value mapping
calculatePriority :: Map Char Int -> [Char] -> Int
calculatePriority value items = sum [value ! item | item <- items]

-- Generates the inventory from lines, splitting each line into two parts
generateInventory :: [String] -> [[String]]
generateInventory flines = [[take (length line `div` 2) line, drop (length line `div` 2) line] | line <- flines]

-- Calculates the mistakes by finding the intersection of the two parts in each bag
calculateMistakes :: [[String]] -> [Char]
calculateMistakes inventory = [head $ head bag `intersect` (bag !! 1) | bag <- inventory]

-- Groups lines into groups of three
groupLines :: [String] -> [[String]]
groupLines flines = [take 3 (drop (i - 1) flines) | i <- [1, 4 .. length flines]]

-- Calculates the badges by finding the intersection of all elves in each group
calculateBadges :: [[String]] -> [Char]
calculateBadges groups = [head $ foldr1 intersect elves | elves <- groups]

-- Processes the file, performs calculations, and prints the results
processFile :: FilePath -> IO ()
processFile filePath = do
  file_lines <- fmap lines (readFile filePath)

  -- Value mapping for item priorities
  let value =
        fromList
          [ ('a', 1),
            ('b', 2),
            ('c', 3),
            ('d', 4),
            ('e', 5),
            ('f', 6),
            ('g', 7),
            ('h', 8),
            ('i', 9),
            ('j', 10),
            ('k', 11),
            ('l', 12),
            ('m', 13),
            ('n', 14),
            ('o', 15),
            ('p', 16),
            ('q', 17),
            ('r', 18),
            ('s', 19),
            ('t', 20),
            ('u', 21),
            ('v', 22),
            ('w', 23),
            ('x', 24),
            ('y', 25),
            ('z', 26),
            ('A', 27),
            ('B', 28),
            ('C', 29),
            ('D', 30),
            ('E', 31),
            ('F', 32),
            ('G', 33),
            ('H', 34),
            ('I', 35),
            ('J', 36),
            ('K', 37),
            ('L', 38),
            ('M', 39),
            ('N', 40),
            ('O', 41),
            ('P', 42),
            ('Q', 43),
            ('R', 44),
            ('S', 45),
            ('T', 46),
            ('U', 47),
            ('V', 48),
            ('W', 49),
            ('X', 50),
            ('Y', 51),
            ('Z', 52)
          ]

      -- Generate inventory and calculate mistakes
      inventory = generateInventory file_lines
      mistakes = calculateMistakes inventory
      rucksackPriority = calculatePriority value mistakes

      -- Group lines and calculate badges
      groups = groupLines file_lines
      badges = calculateBadges groups
      badgesPriority = calculatePriority value badges

  -- Print the results
  printResults (rucksackPriority, badgesPriority)

-- Prints the results of rucksack priority and badges priority
printResults :: (Int, Int) -> IO ()
printResults (rucksackPriority, badgesPriority) = do
  putStrLn ("The sum of the priorities of the repeated items in the rucksack is " ++ show rucksackPriority)
  putStrLn ("The sum of the priorities of the badges of each group is " ++ show badgesPriority)

-- Main entry point of the program
main :: IO ()
main = processFile "day3.txt"
