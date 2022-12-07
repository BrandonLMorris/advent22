/// Unit tests to verify sample inputs.
import XCTest

final class SampleInputTests: XCTestCase {
  private let day1Input = [
    "1000", "2000", "3000", "", "4000", "", "5000", "6000", "", "7000", "8000", "9000", "",
    "10000",
  ]
  private var day1: Day01 = Day01()

  override func setUp() {
    day1 = Day01()
  }

  func testDay01Part1SaampleInput() throws {
    let solution = Day01().solvePart1(input: day1Input)
    XCTAssertEqual(solution, "24000")
  }

  func testDay01Part2SaampleInput() throws {
    let solution = Day01().solvePart2(input: day1Input)
    XCTAssertEqual(solution, "45000")
  }
}
