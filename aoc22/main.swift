import ArgumentParser
import Foundation

/// Entry point for all Avdent of Code 2022 solutions.
struct Advent: ParsableCommand {
  @Argument() var day: Int

  func run() throws {
    guard let solver = dayForArgument() else {
      return
    }
    let input = try getInput()
    let result1 = solver.solvePart1(input: input)
    let result2 = solver.solvePart2(input: input)

    print("Solution to day \(day):")
    print("\tPart 1: \(result1)")
    print("\tPart 2: \(result2)")
  }

  func dayForArgument() -> Day? {
    let days: [Day?] = [
      nil,
      Day01(),
      Day02(),
      Day03(),
      Day04(),
      Day05(),
      Day06(),
      Day07(),
      Day08(),
      Day09(),
    ]
    if day < 1 || day > days.count - 1 {
      print("ERROR: Day \(day) is either invalid or unimplemented")
      return nil
    }
    return days[day]
  }

  func getInput() throws -> [String] {
    let inputDir = FileManager.default.currentDirectoryPath + "/input/"
    let fileName = String(format: "day%02d.txt", day)
    let fileInput = try String(contentsOfFile: inputDir + fileName)
    return fileInput.components(separatedBy: "\n")
  }
}

Advent.main()
