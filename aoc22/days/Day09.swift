/// Solution to Advent of Code 2022 Day 9.
///
/// https://adventofcode.com/2022/day/9

internal struct Day09: Day {
  func solvePart1(input: [String]) -> String {
    let directions = parseDirections(input)
    let headPath = createHeadPath(from: directions)
    let tailPath = createTailPath(from: headPath)
    return String(Set(tailPath).count)
  }

  func solvePart2(input: [String]) -> String {
    let directions = parseDirections(input)
    let headPath = createHeadPath(from: directions)
    var knotPath = createTailPath(from: headPath)
    // Calculate the paths for knots 2-9
    for _ in 2...9 {
      knotPath = createTailPath(from: knotPath)
    }
    return String(Set(knotPath).count)
  }

  private func parseDirections(_ input: [String]) -> [Direction] {
    var directions: [Direction] = []
    for line in input {
      if line.isEmpty { continue }
      let split = line.components(separatedBy: " ")
      let direction = split[0]
      let count = Int(split[1])!
      for _ in 0..<count {
        directions.append(Direction(rawValue: direction)!)
      }
    }
    return directions
  }

  private func createHeadPath(from directions: [Direction]) -> [Point] {
    var pos = Point(x: 0, y: 0)
    var path = [pos]

    for direction in directions {
      switch direction {
      case .up:
        pos = Point(x: pos.x, y: pos.y + 1)
      case .down:
        pos = Point(x: pos.x, y: pos.y - 1)
      case .left:
        pos = Point(x: pos.x - 1, y: pos.y)
      case .right:
        pos = Point(x: pos.x + 1, y: pos.y)
      }
      path.append(pos)
    }

    return path
  }

  private func createTailPath(from headPath: [Point]) -> [Point] {
    var pos = Point(x: 0, y: 0)
    var path = [pos]

    for headPos in headPath {
      // Two steps, but same row/col
      if abs(pos.x - headPos.x) == 2 && pos.y == headPos.y {
        // Move in the direction of the head
        let xDelta = headPos.x > pos.x ? 1 : -1
        pos = Point(x: pos.x + xDelta, y: pos.y)
      }
      if pos.x == headPos.x && abs(pos.y - headPos.y) == 2 {
        // Move in the direction of the head
        let yDelta = headPos.y > pos.y ? 1 : -1
        pos = Point(x: pos.x, y: pos.y + yDelta)
      }

      // Diagonal move: Two steps and different row/col
      if abs(pos.x - headPos.x) == 2 && pos.y != headPos.y
        || pos.x != headPos.x && abs(pos.y - headPos.y) == 2
      {
        let xDelta = headPos.x > pos.x ? 1 : -1
        let yDelta = headPos.y > pos.y ? 1 : -1
        pos = Point(x: pos.x + xDelta, y: pos.y + yDelta)
      }

      path.append(pos)
    }

    return path
  }
}

private enum Direction: String {
  case left = "L"
  case right = "R"
  case up = "U"
  case down = "D"
}

private struct Point: Hashable {
  let x: Int, y: Int
}
