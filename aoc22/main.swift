/// Entry point for all Avdent of Code 2022 solutions.
import Foundation

let inputDir = FileManager.default.currentDirectoryPath + "/input/"
let fileInput = try String(contentsOfFile: inputDir + "day01.txt")
let result = Day01().solve(input: fileInput.components(separatedBy: "\n"))

print("Solution to day01 is \(result)")
