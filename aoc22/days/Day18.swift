//
//  Day18.swift
//  aoc22
//
//  Created by Brandon Morris on 11/22/23.
//

internal struct Day18: Day {
  func solvePart1(input: [String]) -> String {
    let lava = Set(input.filter { !$0.isEmpty }.map { Coordinate.fromInputLine($0) })
    return "\(countExposedSides(lava))"
  }

  func solvePart2(input: [String]) -> String {
    let lava = Set(input.filter { !$0.isEmpty }.map { Coordinate.fromInputLine($0) })
    let exposedAir = calcExposedAir(lava)
    return "\(countExposedSides(lava, from: exposedAir))"
  }

  private func countExposedSides(_ lava: Set<Coordinate>, from: Set<Coordinate>? = nil) -> Int {
    var exposed = 0
    for coord in lava {
      for neighbor in coord.neighbors {
        if !lava.contains(neighbor) {
          // Skip points that are not in the external air if provided (pt2)
          if let externalAir = from {
            if !externalAir.contains(neighbor) { continue }
          }
          exposed += 1
        }
      }
    }
    return exposed
  }

  /// Perform a flood fill across our "lava space" to find all the exposed air coordinates.
  private func calcExposedAir(_ lava: Set<Coordinate>) -> Set<Coordinate> {
    // Create the bounds of our search space for flood fill
    let xUpperBound = lava.map { $0.x }.max()! + 1
    let xLowerBound = lava.map { $0.x }.min()! - 1
    let yUpperBound = lava.map { $0.y }.max()! + 1
    let yLowerBound = lava.map { $0.y }.min()! - 1
    let zUpperBound = lava.map { $0.z }.max()! + 1
    let zLowerBound = lava.map { $0.z }.min()! - 1
    func inBounds(_ c: Coordinate) -> Bool {
      return c.x <= xUpperBound && c.x >= xLowerBound
        && c.y <= yUpperBound && c.y >= yLowerBound
        && c.z <= zUpperBound && c.z >= zLowerBound
    }

    var exposed = Set<Coordinate>()
    var visited = Set<Coordinate>()
    var toExplore = [Coordinate(x: xLowerBound, y: yLowerBound, z: zLowerBound)]
    while !toExplore.isEmpty {
      let current = toExplore.popLast()!
      visited.insert(current)
      if !lava.contains(current) {
        exposed.insert(current)
      }
      for neighbor in current.neighbors {
        // Skip searching outside bounds and on lava spaces
        if inBounds(neighbor) && !lava.contains(neighbor) && !visited.contains(neighbor) {
          toExplore.append(neighbor)
        }
      }
    }
    return exposed
  }
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
