//
//  Day18.swift
//  aoc22
//
//  Created by Brandon Morris on 11/22/23.
//

internal struct Day18: Day {
  func solvePart1(input: [String]) -> String {
    let lava = Set(input.filter { !$0.isEmpty }.map { Coordinate.fromInputLine($0) })
    var exposed = 0
    for coord in lava {
      for neighbor in coord.neighbors {
        if !lava.contains(neighbor) {
          exposed += 1
        }
      }
    }
    return "\(exposed)"
  }

  func solvePart2(input: [String]) -> String { "TODO" }
}

private struct Coordinate: Hashable {
  let x: Int, y: Int, z: Int

  static func fromInputLine(_ inputLine: String) -> Coordinate {
    let coords = inputLine.components(separatedBy: ",")
    return Coordinate(
      x: Int(coords[0])!,
      y: Int(coords[1])!,
      z: Int(coords[2])!
    )
  }

  var neighbors: [Coordinate] {
    [
      Coordinate(x: x + 1, y: y, z: z),
      Coordinate(x: x - 1, y: y, z: z),
      Coordinate(x: x, y: y + 1, z: z),
      Coordinate(x: x, y: y - 1, z: z),
      Coordinate(x: x, y: y, z: z + 1),
      Coordinate(x: x, y: y, z: z - 1),
    ]
  }
}
