/// Unit tests to verify sample inputs.
import XCTest

final class SampleInputTests: XCTestCase {
  func testDay01SaampleInput() throws {
    let inputLines = [
      "1000", "2000", "3000", "", "4000", "", "5000", "6000", "", "7000", "8000", "9000", "",
      "10000",
    ]
    let solution = Day01().solve(input: inputLines)
    XCTAssertEqual(solution, "24000")
  }
}
