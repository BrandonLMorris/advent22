/// Solution to Advent of Code 2022 Day 7.
///
/// https://adventofcode.com/2022/day/7

class Day07: Day {
  func solvePart1(input: [String]) -> String {
    let result = diskUsage(input).values.filter({ $0 < 100000 }).reduce(0, +)

    return String(result)
  }

  func solvePart2(input: [String]) -> String {
    let usage = diskUsage(input)
    let rootSize = usage["/"]!
    let result = usage.values.filter({ rootSize - $0 <= 40_000_000 }).min()!
    return String(result)
  }
}

private func diskUsage(_ input: [String]) -> [String: Int] {
  var dirSizes = ["/": 0]
  var path = ["/"]

  for line in input {
    if line.isEmpty { continue }
    if line.starts(with: "$ cd") {
      let dest = line.components(separatedBy: " ").last!
      switch dest {
      case "/":
        path = ["/"]
      case "..":
        let _ = path.popLast()
      default:
        path.append(dest)
      }
    } else {
      // This line is either the ls command or part of the ls output
      if line == "$ ls" || line.starts(with: "dir") { continue }
      let fileSize = Int(line.components(separatedBy: " ").first!)!
      // Add the file size to the disk usage of every directory on the path
      for i in 0..<(path.count + 1) {
        let absPath = path[0..<i].joined(separator: "-")
        dirSizes[absPath] = (dirSizes[absPath] ?? 0) + fileSize
      }
    }
  }

  return dirSizes
}
