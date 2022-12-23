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
  private let day7Input = [
    "$ cd /",
    "$ ls",
    "dir a",
    "14848514 b.txt",
    "8504156 c.dat",
    "dir d",
    "$ cd a",
    "$ ls",
    "dir e",
    "29116 f",
    "2557 g",
    "62596 h.lst",
    "$ cd e",
    "$ ls",
    "584 i",
    "$ cd ..",
    "$ cd ..",
    "$ cd d",
    "$ ls",
    "4060174 j",
    "8033020 d.log",
    "5626152 d.ext",
    "7214296 k",
  ]
  private let day8Input = [
    "30373",
    "25512",
    "65332",
    "33549",
    "35390",
  ]
  private let day9Input = [
    "R 4",
    "U 4",
    "L 3",
    "D 1",
    "R 4",
    "D 1",
    "L 5",
    "R 2",
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

  func testDay07Part1SampleInput() throws {
    let solution = Day07().solvePart1(input: day7Input)
    XCTAssertEqual(solution, "95437")
  }

  func testDay08Part1SampleInput() throws {
    let solution = Day08().solvePart1(input: day8Input)
    XCTAssertEqual(solution, "21")
  }

  func testDay08Part2SampleInput() throws {
    let solution = Day08().solvePart2(input: day8Input)
    XCTAssertEqual(solution, "8")
  }

  func testDay09Part1SampleInput() throws {
    let solution = Day09().solvePart1(input: day9Input)
    XCTAssertEqual(solution, "13")
  }
}
