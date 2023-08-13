//
//  Day16.swift
//  aoc22
//
//  https://adventofcode.com/2022/day/16
//

internal struct Day16: Day {

  func solvePart1(input: [String]) -> String {
    var cave = Cave(input.filter { !$0.isEmpty })
    let possibleStates = createPossibleStates(&cave, time: 30)
    let maxPressure = possibleStates.max(by: { $0.pressure < $1.pressure })!.pressure
    return "\(maxPressure)"
  }

  func solvePart2(input: [String]) -> String {
    var cave = Cave(input.filter { !$0.isEmpty })
    let possibleStates = createPossibleStates(&cave, time: 26)
    let maxPressure = maxPressureOfTwoStates(possibleStates, cave: cave)
    return "\(maxPressure)"
  }

  private func createPossibleStates(_ cave: inout Cave, time: Int) -> [CaveState] {
    let distances = cave.createDistanceMatrix()

    let initial = CaveState(
      currentValve: cave.valves["AA"], visited: Set<Valve>(), minutesLeft: time, pressure: 0)
    var queue = [initial]
    var possibleStates = [CaveState]()

    while let current = queue.popLast() {
      possibleStates.append(current)

      // Consider each valve with non-zero flow as possible next
      for maybeNext in cave.positiveFlowValves {
        if let newState = current.visit(maybeNext, distances: distances) {
          queue.append(newState)
        }
      }
    }
    return possibleStates
  }

  private func maxPressureOfTwoStates(_ caveStates: [CaveState], cave: Cave) -> Int {
    let initValve = cave.valves["AA"]
    var maxPressure = -1
    for i in 0..<caveStates.count {
      for j in i..<caveStates.count {
        let state1 = caveStates[i]
        let state2 = caveStates[j]
        if state1.visited.intersection(state2.visited).subtracting([initValve]).isEmpty {
          // No overlapping valves
          maxPressure = max(maxPressure, state1.pressure + state2.pressure)
        }
      }
    }
    return maxPressure
  }
}

private struct Valve: Equatable, Hashable, CustomStringConvertible {
  let name: String
  let flowRate: Int

  init(_ line: String) {
    name = line.components(separatedBy: " ")[1]
    let flowRateStart = line.index(after: line.firstIndex(of: "=")!)
    let flowRateRange = flowRateStart..<line.firstIndex(of: ";")!
    flowRate = Int(line[flowRateRange])!
  }

  var description: String { return "\(name)(\(flowRate))" }
}

extension Array where Element == Valve {
  fileprivate subscript(name: String) -> Valve {
    self.first(where: { name == $0.name })!
  }
}

private struct Cave: CustomStringConvertible {
  let valves: [Valve]
  private let adjacencies: [Valve: [Valve]]

  init(_ input: [String]) {
    let valves = input.map { Valve($0) }
    var neighbors = [Valve: [Valve]]()

    for line in input {
      // Example line:
      // Valve AA has flow rate=0; tunnels lead to valves DD, II, BB
      var neighborNames = line.components(separatedBy: "valve")[1].components(separatedBy: " ")
      // The first element is a blank space or "s " if multiple neighbors
      neighborNames.removeFirst()
      for idx in 0..<neighborNames.count {
        let name = neighborNames[idx]
        if name.last! == "," {
          neighborNames[idx] = name.components(separatedBy: ",")[0]
        }
      }
      let currentValve = Valve(line)
      neighbors[currentValve] = neighborNames.map { valves[$0] }
    }
    adjacencies = neighbors
    self.valves = valves
  }

  lazy var positiveFlowValves: [Valve] = {
    return valves.filter { $0.flowRate > 0 }
  }()

  var description: String {
    var result: String = ""
    for valve in valves {
      let neighbors: [Valve] = adjacencies[valve]!
      let neighborStr = neighbors.map { $0.name }.joined(separator: ", ")
      result += "\(valve.name) (\(valve.flowRate)) -> \(neighborStr)\n"
    }
    return result
  }

  func createDistanceMatrix() -> [Path: Int] {
    var distances = [Path: Int]()
    // Initialize the distance matrix with direct neighbors
    for start in valves {
      for end in valves {
        let p = Path(start, end)
        distances[p] = start == end ? 0 : Int.max
        if adjacencies[start]?.contains(end) ?? false {
          // It takes one minute to move between direct neighbors
          distances[p] = 1
        }
      }
    }

    // For each pair of valves, consider every node as a possible intermediate
    // for a shorter path (Floyd-Warshall).
    for _ in 0...1 {
      for start in valves {
        for end in valves {
          for possibleIntermediate in valves {
            let p = Path(start, end)
            let firstLeg = Path(start, possibleIntermediate)
            let secondLeg = Path(possibleIntermediate, end)
            if distances[firstLeg] == Int.max || distances[secondLeg] == Int.max { continue }
            distances[p] = min(distances[p]!, distances[firstLeg]! + distances[secondLeg]!)
          }
        }
      }
    }

    // Filter out any paths that aren't possible or are just paths to self
    for start in valves {
      for end in valves {
        let p = Path(start, end)
        if distances[p] == Int.max || start == end {
          distances.removeValue(forKey: p)
        }
      }
    }

    // Remove any zero-flow valves (except for the starting point), since we
    // should never waste time traveling to them (travelling through them is
    // already included in the distances).
    for (p, _) in distances {
      if p.start.name == "AA" { continue }
      if p.start.flowRate == 0 || p.end.flowRate == 0 {
        distances.removeValue(forKey: p)
      }
    }

    return distances
  }
}

/// A simple container representing moving from one valve to another.
///
/// We're not using a simple tuple since they can't be used as dictionary keys.
private struct Path: Hashable, CustomStringConvertible {
  let start: Valve
  let end: Valve

  init(_ start: Valve, _ end: Valve) {
    self.start = start
    self.end = end
  }

  var description: String {
    return "\(start)->\(end)"
  }
}

private struct CaveState: CustomStringConvertible {
  let currentValve: Valve
  let visited: Set<Valve>
  let minutesLeft: Int
  let pressure: Int

  var description: String {
    return """
      At valve \(currentValve.name) with pressure \(pressure) and \(minutesLeft) time left
        open: [\(visited.map { "\($0.name)" }.joined(separator: ","))]
      """
  }

  /// Create a new CaveState by trying to visit a valve.
  func visit(_ dest: Valve, distances: [Path: Int]) -> CaveState? {
    // Skip nodes we've visited on this route; we can't open them again
    if self.visited.contains(dest) { return nil }
    guard let dist = distances[Path(self.currentValve, dest)] else { return nil }

    let timeAfterOpening = self.minutesLeft - dist - 1
    if timeAfterOpening <= 0 { return nil }
    let additionalPressure = timeAfterOpening * dest.flowRate
    var newVisited = self.visited
    newVisited.insert(dest)
    return CaveState(
      currentValve: dest, visited: newVisited, minutesLeft: timeAfterOpening,
      pressure: self.pressure + additionalPressure)
  }
}
