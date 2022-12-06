/// Solution to Advent of Code 2022 Day 1.
///
/// https://adventofcode.com/2022/day/1

class Day01 : Day {
    func solve(input: [String]) -> String {
        var calorieTotals: [Int] = []
        var calorieSum = 0
        for line in input {
            if line.isEmpty {
                calorieTotals.append(calorieSum)
                calorieSum = 0
            } else {
                calorieSum += Int(line) ?? 0
            }
        }
        // Don't forget to add the last one
        calorieTotals.append(calorieSum)

        return String(calorieTotals.max()!)
    }
}
