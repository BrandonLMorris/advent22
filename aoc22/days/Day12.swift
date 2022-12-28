/// Solution to Advent of Code 2022 Day 12.
///
/// https://adventofcode.com/2022/day/12

internal struct Day12: Day {
  func solvePart1(input: [String]) -> String {
    var map = AltitudeMap(lines: input)
    return String(map.distanceToTop)
  }

  func solvePart2(input: [String]) -> String { return "TODO" }
}

fileprivate struct AltitudeMap {
  private let altitudes: [[Int]]
  private let start: Point
  private let end: Point

  lazy var distanceToTop: Int = {
    computeDistance()
  }()

  init(lines: [String]) {
    var start: Point? = nil
    var end: Point? = nil
    var alts: [[Int]] = []

    for row in 0..<lines.count {
      var altRow: [Int] = []
      for col in 0..<lines[0].count {
        let line = lines[row]
        if line.isEmpty { continue }

        let rowIdx = line.index(line.startIndex, offsetBy: col)
        altRow.append(line[rowIdx].toAltitude())
        if line[rowIdx] == "S" { start = Point(row: row, col: col) }
        if line[rowIdx] == "E" { end = Point(row: row, col: col) }
      }
      if !altRow.isEmpty { alts.append(altRow) }
    }

    altitudes = alts
    self.start = start!
    self.end = end!
  }

  private func computeDistance() -> Int {
    var visited = Set<Point>()
    var toVisit = [start]
    var distances: [Point: Int] = [start: 0]

    while !toVisit.isEmpty {
      let current = toVisit.removeFirst()
      if visited.contains(current) { continue }
      visited.insert(current)
      for newNeighbor in neighbors(for: current).subtracting(visited) {
        toVisit.append(newNeighbor)
        distances[newNeighbor] = distances[current]! + 1
      }
    }

    return distances[end] ?? -1
  }

  private func neighbors(for point: Point) -> Set<Point> {
    let result = [
      Point(row: point.row - 1, col: point.col),  // Up
      Point(row: point.row + 1, col: point.col),  // Down
      Point(row: point.row, col: point.col - 1),  // Left
      Point(row: point.row, col: point.col + 1),  // Right
    ].filter({ p in
      p.row >= 0 && p.col >= 0 &&
      p.row < altitudes.count &&
      p.col < altitudes[0].count &&
      elevation(at: p) - elevation(at: point) <= 1
    })
    return Set(result)
  }

  private func elevation(at point: Point) -> Int {
    return altitudes[point.row][point.col]
  }

  private struct Point: Hashable {
    let row: Int, col: Int
  }
}

fileprivate extension Character {
  func toAltitude() -> Int {
    let zeroAlt = Int(Character("a").asciiValue!)
    switch self {
    case "S":
      return 0
    case "E":
      return Int(Character("z").asciiValue!) - zeroAlt
    default:
      return Int(asciiValue!) - zeroAlt
    }
  }
}
