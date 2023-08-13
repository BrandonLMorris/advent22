//
//  Day17.swift
//  aoc22
//
//  https://adventofcode.com/2022/day/17
//

internal struct Day17: Day {
  func solvePart1(input: [String]) -> String {
    let jetPattern = input.filter { !$0.isEmpty }.first!
    let chamber = Chamber(jetPatternString: jetPattern)
    while (chamber.fallenRocks < 2022) { chamber.tick() }
    return "\(chamber.highestRow)"
  }

  func solvePart2(input: [String]) -> String { return "TODO" }
}

/// The tall, vertical chamber through which rocks fall.
///
/// The chamber is infinitely tall, but only 7 units wide. When a new
/// rock begins to fall, it starts on the third position from the right and
/// three units above the highest rock (or floor).
private class Chamber {
  // All the points in the chamber currently occupied by stationary rock.
  var stationaryRocks = Set<Point>()
  private(set) var fallenRocks = 0
  private(set) var highestRow = 0
  private let jetPattern: [Direction]
  private var jetPatternIdx = 0
  private var fallingRock: Rock? = nil

  let rockShapeOrder: [Rock.RockShape] = [.horizontal, .plus, .angle, .vertical, .square]

  init(jetPatternString: String) {
    jetPattern = jetPatternString.compactMap { Direction.create($0) }
  }

  func tick() {
    // If there isn't a rock currently falling, add one first
    if fallingRock == nil {
      fallingRock = newRock()
    }

    // Try to move the rock according to the jet pattern. Failure to move is
    // ignored here.
    let jetDir = jetPattern[jetPatternIdx]
    jetPatternIdx = (jetPatternIdx + 1) % jetPattern.count
    blowRock(toSide: jetDir)

    // Try to make the rock fall one unit. Failure here means the rock can't
    // fall any more, so update our state and counters.
    if !fall() {
      fallingRock!.points.forEach {
        highestRow = max(highestRow, $0.y + 1)
        stationaryRocks.insert($0)
      }
      fallingRock = nil
      fallenRocks += 1
    }
  }

  private func newRock() -> Rock {
    let rockShape = rockShapeOrder[fallenRocks % rockShapeOrder.count]
    return Rock.create(shape: rockShape, on: Point(2, highestRow + 3))
  }

  private func blowRock(toSide direction: Direction) {
    let possible = fallingRock!.move(direction)
    if validRockPos(possible) {
      fallingRock = possible
    }
  }

  /// Attempt to drop the falling rock one unit down. Returns whether the
  /// rock actually moved.
  private func fall() -> Bool {
    let possible = fallingRock!.move(.down)
    if validRockPos(possible) {
      fallingRock = possible
      return true
    }
    return false
  }

  private func validRockPos(_ rock: Rock) -> Bool {
    for point in rock.points {
      // Check if we're in the boundaries of the chamber.
      if point.x < 0 || point.x > 6 { return false }
      if point.y < 0 { return false }

      // Check if we're overlapping with any existing rocks.
      if stationaryRocks.contains(point) {
        return false
      }
    }
    return true
  }
}

private struct Point: Hashable, Equatable {
  // Column position, going from the left wall of the chamber. Only values 0-6
  // are actually inside the chamber.
  let x: Int
  // Row position, starting from the floor. Cannot be negative and be inside
  // the chamber.
  let y: Int

  init(_ x: Int, _ y: Int) {
    self.x = x
    self.y = y
  }
}

private enum Direction {
  case left, right, down

  static func create(_ c: Character) -> Direction? {
    if c == "<" { return .left }
    if c == ">" { return .right }
    return nil
  }
}

/// A rock is a collection of points that moves in unison.
private struct Rock {
  let points: Set<Point>

  enum RockShape {
    case horizontal, plus, angle, vertical, square
  }

  func move(_ direction: Direction) -> Rock {
    var xOffset = 0
    var yOffset = 0
    switch direction {
    case .left:
      xOffset = -1
    case .right:
      xOffset = 1
    case .down:
      yOffset = -1
    }
    return Rock(points: Set(self.points.map { Point($0.x + xOffset, $0.y + yOffset) }))
  }

  static func create(shape: RockShape, on: Point) -> Rock {
    switch shape {
    case .horizontal:
      return placeHorizontal(on: on)
    case .plus:
      return placePlus(on: on)
    case .angle:
      return placeAngle(on: on)
    case .vertical:
      return placeVertical(on: on)
    case .square:
      return placeSquare(on: on)
    }
  }

  static private func placeHorizontal(on: Point) -> Rock {
    return Rock(points: [
      Point(on.x, on.y),
      Point(on.x + 1, on.y),
      Point(on.x + 2, on.y),
      Point(on.x + 3, on.y),
    ])
  }

  static private func placeVertical(on: Point) -> Rock {
    return Rock(points: [
      Point(on.x, on.y),
      Point(on.x, on.y + 1),
      Point(on.x, on.y + 2),
      Point(on.x, on.y + 3),
    ])
  }

  static private func placeSquare(on: Point) -> Rock {
    return Rock(points: [
      Point(on.x, on.y),
      Point(on.x, on.y + 1),
      Point(on.x + 1, on.y),
      Point(on.x + 1, on.y + 1),
    ])
  }

  static private func placePlus(on: Point) -> Rock {
    return Rock(points: [
      Point(on.x + 1, on.y),
      Point(on.x, on.y + 1),
      Point(on.x + 1, on.y + 1),
      Point(on.x + 2, on.y + 1),
      Point(on.x + 1, on.y + 2),
    ])
  }

  static private func placeAngle(on: Point) -> Rock {
    return Rock(points: [
      Point(on.x, on.y),
      Point(on.x + 1, on.y),
      Point(on.x + 2, on.y),
      Point(on.x + 2, on.y + 1),
      Point(on.x + 2, on.y + 2),
    ])
  }
}
