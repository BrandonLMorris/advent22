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
  private let day4Input = [
    "2-4,6-8",
    "2-3,4-5",
    "5-7,7-9",
    "2-8,3-7",
    "6-6,4-6",
    "2-6,4-8",
  ]
  private let day5Input = [
    "    [D]    ",
    "[N] [C]    ",
    "[Z] [M] [P]",
    " 1   2   3 ",
    "",
    "move 1 from 2 to 1",
    "move 3 from 1 to 3",
    "move 2 from 2 to 1",
    "move 1 from 1 to 2",
  ]
  private let day6Input = ["mjqjpqmgbljsphdztnvjfqwrcgsmlb"]

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

  func testDay04Part1SampleInput() throws {
    let solution = Day04().solvePart1(input: day4Input)

    XCTAssertEqual(solution, "2")
  }

  func testDay04Part2SampleInput() throws {
    let solution = Day04().solvePart2(input: day4Input)

    XCTAssertEqual(solution, "4")
  }

  func testDay05Part1SampleInput() throws {
    let solution = Day05().solvePart1(input: day5Input)

    XCTAssertEqual(solution, "CMZ")
  }

  func testDay05Part2SampleInput() throws {
    let solution = Day05().solvePart2(input: day5Input)
    XCTAssertEqual(solution, "MCD")
  }
  
  func testDay06Part1SampleInput() throws {
    let solution = Day06().solvePart1(input: day6Input)
    XCTAssertEqual(solution, "7")
  }

  func testDay06Part2SampleInput() throws {
    let solution = Day06().solvePart2(input: day6Input)
    XCTAssertEqual(solution, "19")
  }
}
