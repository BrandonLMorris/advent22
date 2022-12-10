/// Unit tests to verify sample inputs.
import XCTest

final class SampleInputTests: XCTestCase {
  private let day1Input = [
    "1000", "2000", "3000", "", "4000", "", "5000", "6000", "", "7000", "8000", "9000", "",
    "10000",
  ]
  private let day2Input = ["A Y", "B X", "C Z"]
  private let day3Input = [
    "vJrwpWtwJgWrhcsFMMfFFhFp",
    "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL",
    "PmmdzqPrVvPwwTWBwg",
    "wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn",
    "ttgJtRGJQctTZtZT",
    "CrZsJsPPZsGzwwsLwLmpwMDw",
  ]

  func testDay01Part1SaampleInput() throws {
    let solution = Day01().solvePart1(input: day1Input)
    XCTAssertEqual(solution, "24000")
  }

  func testDay01Part2SaampleInput() throws {
    let solution = Day01().solvePart2(input: day1Input)
    XCTAssertEqual(solution, "45000")
  }

  func testDay02Part1SampleInput() throws {
    let solution = Day02().solvePart1(input: day2Input)
    XCTAssertEqual(solution, "15")
  }

  func testDay02Part2SampleInput() throws {
    let solution = Day02().solvePart2(input: day2Input)
    XCTAssertEqual(solution, "12")
  }

  func testDay03Part1SampleInput() throws {
    let solution = Day03().solvePart1(input: day3Input)

    XCTAssertEqual(solution, "157")
  }

  func testDay03Part2SampleInput() throws {
    let solution = Day03().solvePart2(input: day3Input)

    XCTAssertEqual(solution, "70")
  }
}
