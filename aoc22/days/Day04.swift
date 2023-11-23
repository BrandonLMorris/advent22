/// Solution to Advent of Code 2022 Day 4.
///
/// https://adventofcode.com/2022/day/4

import Foundation

class Day04: Day {
  func solvePart1(input: [String]) -> String {
    let result =
      input
      .filter({ !$0.isEmpty })
      .map({ parseLine(line: $0) }).filter({
        // Count the assignment if either shift "fully contains" the other
        $0.contains($1) || $1.contains($0)
      }).count
    return String(result)
  }

  func solvePart2(input: [String]) -> String {
    let result =
      input
      .filter({ !$0.isEmpty })
      .map({ parseLine(line: $0) }).filter({
        // Count the assignment if either shift "fully contains" the other
        $0.overlaps($1)
      }).count
    return String(result)
  }

  func parseLine(line: String) -> (SectionAssignment, SectionAssignment) {
    let assignments = line.components(separatedBy: ",")
    return (SectionAssignment(assignments.first!), SectionAssignment(assignments.last!))
  }
}

struct SectionAssignment {
  let start: Int
  let end: Int
}

extension SectionAssignment {
  init(_ abbreviated: String) {
    let sectionEnds = abbreviated.components(separatedBy: "-")
    start = Int(sectionEnds.first!)!
    end = Int(sectionEnds.last!)!
  }

  func contains(_ other: SectionAssignment) -> Bool {
    return self.start <= other.start && self.end >= other.end
  }

  func overlaps(_ other: SectionAssignment) -> Bool {
    // If there's no overlap, this interval has to end before
    // the other begins or begin after the other one ends.
    return !(self.end < other.start || self.start > other.end)
  }
}
