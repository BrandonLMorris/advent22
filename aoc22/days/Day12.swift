/// Solution to Advent of Code 2022 Day 12.
///
/// https://adventofcode.com/2022/day/12

internal struct Day12: Day {
  func solvePart1(input: [String]) -> String {
    var map = AltitudeMap(lines: input)
    return String(map.distanceToTop)
  }

  func solvePart2(input: [String]) -> String {
    var map = AltitudeMap(lines: input)
    return String(map.shortestCompleteDistance)
  }
}

private struct AltitudeMap {
  private let altitudes: [[Int]]
  private let start: Point
  private let end: Point

  lazy var distanceToTop: Int = {
    computeDistance(from: start, toPointWhere: { $0 == end })
  }()

  lazy var shortestCompleteDistance: Int = {
    computeDistance(from: end, toPointWhere: { elevation(at: $0) == 0 }, traveling: .down)
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

  private enum TravelDirection {
    case up, down
  }

  private func computeDistance(
    from startPoint: Point, toPointWhere matcher: (Point) -> Bool,
    traveling direction: TravelDirection = .up
  ) -> Int {
    var visited = Set<Point>()
    var toVisit = [startPoint]
    var distances: [Point: Int] = [startPoint: 0]

    while !toVisit.isEmpty {
      let current = toVisit.removeFirst()
      if visited.contains(current) { continue }
      visited.insert(current)

      for newNeighbor in neighbors(for: current, going: direction).subtracting(visited) {
        toVisit.append(newNeighbor)
        if matcher(newNeighbor) {
          return distances[current]! + 1
        } else {
          distances[newNeighbor] = distances[current]! + 1
        }
      }
    }

    // Indicates that no such path is possible.
    return -1
  }

  private func neighbors(for point: Point, going direction: TravelDirection) -> Set<Point> {
    let result = [
      Point(row: point.row - 1, col: point.col),  // Up
      Point(row: point.row + 1, col: point.col),  // Down
      Point(row: point.row, col: point.col - 1),  // Left
      Point(row: point.row, col: point.col + 1),  // Right
    ].filter({ p in
      // Ensure the new neighbor is in bounds.
      p.row >= 0 && p.col >= 0 && p.row < altitudes.count && p.col < altitudes[0].count
    }).filter({ p in
      // Ensure the new neighbor is within one level of altitude, depending on direction.
      switch direction {
      case .up:
        return elevation(at: p) - elevation(at: point) <= 1
      case .down:
        return elevation(at: point) - elevation(at: p) <= 1
      }
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

extension Character {
  fileprivate func toAltitude() -> Int {
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
