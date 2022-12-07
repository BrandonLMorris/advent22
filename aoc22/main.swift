import ArgumentParser
import Foundation

/// Entry point for all Avdent of Code 2022 solutions.
struct Advent: ParsableCommand {
  @Argument() var day: Int

  func run() throws {
    guard validateArgs() else {
      return
    }

    let input = try getInput()
    let solver = Day01()
    let result1 = solver.solvePart1(input: input)
    let result2 = solver.solvePart2(input: input)

    print("Solution to day \(day):\n\(result1)\n\(result2)")
  }

  func validateArgs() -> Bool {
    if day < 1 || day > 1 {
      print("ERROR: Day \(day) is either invalid or unimplemented")
      return false
    }
    return true
  }

  func getInput() throws -> [String] {
    let inputDir = FileManager.default.currentDirectoryPath + "/input/"
    let fileName = String(format: "day%02d.txt", day)
    let fileInput = try String(contentsOfFile: inputDir + fileName)
    return fileInput.components(separatedBy: "\n")
  }
}

Advent.main()
