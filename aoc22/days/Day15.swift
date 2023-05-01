//
//  Day15.swift
//  aoc22
//
//  https://adventofcode.com/2022/day/15
//

internal struct Day15: Day {
  let rowOfInterest: Int

  init(rowOfInterest: Int = 2_000_000) {
    self.rowOfInterest = rowOfInterest
  }

  func solvePart1(input: [String]) -> String {
    let sensors = [Sensor](input)
    var count = 0
    for x in sensors.minX...sensors.maxX {
      let pt = Point(x: x, y: rowOfInterest)

      if sensors.sensorLocations.contains(pt) || sensors.beacons.contains(pt) {
        // Point is occupied, so it can't be a spot that
        // cannot contains a beacon.
        continue
      }

      count += sensors.covers(pt) ? 1 : 0
    }
    return String(count)
  }

  func solvePart2(input: [String]) -> String {
    return "TODO"
  }
}

fileprivate extension Array where Element == Sensor {
  init(_ inputLines: [String]) {
    self = inputLines.filter { !$0.isEmpty }.map { Sensor($0) }
  }

  /// The minimum x value that could posibly be covered by these sensors.
  var minX: Int {
    let maxRadius = self.max(by: { $0.radius < $1.radius })!.radius
    let minX = self.min(by: { $0.location.x < $1.location.x })!.location.x
    return minX - maxRadius
  }

  /// The maximum x value that could posibly be covered by these sensors.
  var maxX: Int {
    let maxRadius = self.max(by: { $0.radius < $1.radius })!.radius
    let maxX = self.max(by: { $0.location.x < $1.location.x })!.location.x
    return maxX + maxRadius
  }

  func covers(_ point: Point) -> Bool {
    return self.contains { sensor in
      sensor.location.dist(to: point) <= sensor.radius
    }
  }

  var sensorLocations: [Point] {
    self.map { $0.location }
  }

  var beacons: [Point] {
    self.map { $0.beacon }
  }
}


private struct Point: Equatable, Hashable, CustomStringConvertible {
  let x: Int
  let y: Int

  init(x: Int, y: Int) {
    self.x = x
    self.y = y
  }

  init(_ str: String) {
    // Sensor at x=2832148, y=322979
    let pointPattern = /.*x=([\d-]+), y=([\d-]+)/
    let matched = str.firstMatch(of: pointPattern)!
    x = Int(matched.1)!
    y = Int(matched.2)!
  }

  var description: String {
    "(x=\(x), y=\(y))"
  }

  func dist(to other: Point) -> Int {
    return abs(self.x - other.x) + abs(self.y - other.y)
  }
}

private struct Sensor: CustomStringConvertible {
  let location: Point
  let beacon: Point
  let radius: Int

  init(_ inputLine: String) {
    let lineHalves = inputLine.components(separatedBy: ": ")
    location = Point(lineHalves[0])
    beacon = Point(lineHalves[1])
    radius = beacon.dist(to: location)
  }

  var description: String {
    """
    Sensor at \(location)
    Beacon at \(beacon)
    (radius \(radius))
    """
  }
}
