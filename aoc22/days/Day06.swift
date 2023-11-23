/// Solution to Advent of Code 2022 Day 6.
///
/// https://adventofcode.com/2022/day/6

class Day06: Day {
  func solvePart1(input: [String]) -> String {
    return startLocationForWindowSize(dataStream: input.first!, windowSize: 4)
  }

  func solvePart2(input: [String]) -> String {
    return startLocationForWindowSize(dataStream: input.first!, windowSize: 14)
  }

  func startLocationForWindowSize(dataStream: String, windowSize: Int) -> String {
    var idx = 0
    while idx < dataStream.count {
      let window = DataStreamWindow(dataStream: dataStream, startIndex: idx, size: windowSize)
      if window.allUnique() {
        return String(idx + windowSize)
      }
      idx += 1
    }
    return "ERROR: No Start sequence found"

  }
}

struct DataStreamWindow {
  let contents: [Character]
}

extension DataStreamWindow {
  init(dataStream: String, startIndex: Int, size: Int) {
    let allContents = Array(dataStream)
    contents = Array(allContents[startIndex..<startIndex + size])
  }

  func allUnique() -> Bool {
    return Set(contents).count == contents.count
  }
}
