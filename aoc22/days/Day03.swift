/// Solution to Advent of Code 2022 Day 3.
///
/// https://adventofcode.com/2022/day/3

import Foundation

class Day03: Day {
  func solvePart1(input: [String]) -> String {
    let contentsByCompartment = input.filter({ !$0.isEmpty }).map({ splitRucksack($0) })
    let itemsToSum = contentsByCompartment.map({
      determineCommonItem(firstCompartment: $0, secondCompartment: $1)
    })
    let totalPriority = itemsToSum.map({ toPriority(item: $0) }).reduce(0, +)
    return String(totalPriority)
  }

  func solvePart2(input: [String]) -> String {
    return "TODO"
  }

  func splitRucksack(_ contents: String) -> ([Character], [Character]) {
    let asChars = Array(contents)
    let halfIndex = asChars.count / 2
    let firstCompartment = Array(asChars[..<halfIndex])
    let secondCompartment = Array(asChars[halfIndex..<asChars.count])
    return (firstCompartment, secondCompartment)
  }

  func determineCommonItem(firstCompartment: [Character], secondCompartment: [Character])
    -> Character
  {
    return Set(firstCompartment).intersection(Set(secondCompartment)).first!
  }

  func toPriority(item: Character) -> Int {
    if item.isLowercase {
      return Int(item.asciiValue! - Character("a").asciiValue! + 1)
    } else {
      return Int(item.asciiValue! - Character("A").asciiValue! + 27)
    }
  }
}
