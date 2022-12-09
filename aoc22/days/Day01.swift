/// Solution to Advent of Code 2022 Day 1.
///
/// https://adventofcode.com/2022/day/1

class Day01: Day {
  func solvePart1(input: [String]) -> String {
    let calorieTotals = calculateTotals(calorieCounts: input)

    return String(calorieTotals.max()!)
  }

  func solvePart2(input: [String]) -> String {
    // Return the sum of the top 3
    let calorieTotals = calculateTotals(calorieCounts: input)
    let result = calorieTotals.sorted().reversed()[0...2].reduce(0, +)
    return String(result)
  }

  private func calculateTotals(calorieCounts: [String]) -> [Int] {
    var result: [Int] = []
    var currentSum = 0
    for calories in calorieCounts {
      if calories.isEmpty {
        result.append(currentSum)
        currentSum = 0
      } else {
        currentSum += Int(calories) ?? 0
      }
    }
    // Don't forget to add the last one
    result.append(currentSum)
    return result
  }
}
