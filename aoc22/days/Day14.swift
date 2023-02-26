//
//  Day14.swift
//  aoc22
//
//  https://adventofcode.com/2022/day/14
//

internal struct Day14: Day {
  func solvePart1(input: [String]) -> String {
    let cave = createCave(from: input)
    var sandCount = 0
    while cave.dropSand() != nil { sandCount += 1 }
    return String(sandCount)
  }

  func solvePart2(input: [String]) -> String {
    let cave = createCave(from: input)
    cave.addFloor()
    var sandCount = 0
    let target = Point(row: 0, col: 500)
    while cave.dropSand() != target { sandCount += 1 }
    return String(sandCount + 1)
  }

  private func createCave(from input: [String]) -> Cave {
    var allRocks = Set<Point>()
    for line in input {
      if line.isEmpty { continue }
      let vertices = line.components(separatedBy: " -> ").map({ Point.parse($0) })
      allRocks = allRocks.union(RockPath(vertices: vertices).toCavePoints())
    }
    return Cave(rocks: allRocks)
  }
}

private struct Point: Equatable, Hashable {
  let row: Int
  let col: Int

  static func parse(_ str: String) -> Point {
    let nums = str.components(separatedBy: ",").map({ Int($0)! })
    // assumed to be of the form col,row
    return Point(row: nums[1], col: nums[0])
  }

  static func == (lhs: Point, rhs: Point) -> Bool {
    return lhs.row == rhs.row && lhs.col == rhs.col
  }

  func up() -> Point { Point(row: self.row - 1, col: self.col) }
  func down() -> Point { Point(row: self.row + 1, col: self.col) }
  func right() -> Point { Point(row: self.row, col: col + 1) }
  func left() -> Point { Point(row: self.row, col: col - 1) }
}

enum CavePoint {
  case empty, rock, sand
}

private class Cave {
  private static let caveCols = 800
  private static let caveRows = 200
  private var cavePoints = Array(
    repeating: Array(repeating: CavePoint.empty, count: caveCols), count: caveRows)

  init(rocks: Set<Point>) {
    for p in rocks {
      self[p] = .rock
    }
  }

  subscript(p: Point) -> CavePoint {
    get { return cavePoints[p.row][p.col] }
    set { cavePoints[p.row][p.col] = newValue }
  }

  func addFloor() {
    let floorRow = lowestRow() + 2
    for c in 0..<cavePoints[floorRow].count {
      cavePoints[floorRow][c] = .rock
    }
  }

  func dropSand() -> Point? {
    // Sands start to drop from column 500
    var sandPos = Point(row: -1, col: 500)

    while sandPos.row < Cave.caveRows - 1 {
      let below = sandPos.down()
      if self[below] == .empty {
        sandPos = below
        continue
      }

      let diagLeft = below.left()
      if self[diagLeft] == .empty {
        sandPos = diagLeft
        continue
      }

      let diagRight = below.right()
      if self[diagRight] == .empty {
        sandPos = diagRight
        continue
      }

      // At this point, we can't fall any more
      self[sandPos] = .sand
      return sandPos
    }

    // We've fallen below the bottom of the cave
    return nil
  }

  // Determines the lowest (highest row value) that is non-empty.
  private func lowestRow() -> Int {
    var row = cavePoints.count - 1
    while cavePoints[row].allSatisfy({ $0 == .empty }) {
      row -= 1
    }
    return row
  }
}

private struct RockPath {
  let vertices: [Point]

  func toCavePoints() -> Set<Point> {
    var results = Set<Point>()
    for idx in 0..<vertices.count - 1 {
      connectPoints(vertices[idx], vertices[idx + 1]).forEach { p in results.insert(p) }
    }
    return results
  }

  // TODO this could be consolidated
  private func connectPoints(_ p1: Point, _ p2: Point) -> [Point] {
    var result = [p1]
    if p1.row == p2.row {
      if p2.col > p1.col {
        // To the right
        var point = p1.right()
        while point != p2 {
          result.append(point)
          point = point.right()
        }
      } else {
        // To the left
        var point = p1.left()
        while point != p2 {
          result.append(point)
          point = point.left()
        }
      }
    } else {
      if p2.row < p1.row {
        // Up
        var point = p1.up()
        while point != p2 {
          result.append(point)
          point = point.up()
        }
      } else {
        // Down
        var point = p1.down()
        while point != p2 {
          result.append(point)
          point = point.down()
        }
      }
    }
    result.append(p2)
    return result
  }
}
