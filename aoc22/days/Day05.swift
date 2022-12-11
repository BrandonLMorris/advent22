/// Solution to Advent of Code 2022 Day 4.
///
/// https://adventofcode.com/2022/day/4

import Foundation

class Day05: Day {
  func solvePart1(input: [String]) -> String {
    var (crates, operations) = parseCratesAndInstructions(input)
    operations.forEach({ crates = crates.applyOperation($0) })
    return stacksTopCrateLabels(crateStacks: crates)
  }

  func solvePart2(input: [String]) -> String {
    var (crates, operations) = parseCratesAndInstructions(input)
    operations.forEach({ crates = crates.applyAdvancedOperation($0) })
    return stacksTopCrateLabels(crateStacks: crates)
  }

  func stacksTopCrateLabels(crateStacks: CrateStacks) -> String {
    var result: [Character] = []
    for stack in crateStacks.stacks {
      if stack.isEmpty { continue }
      result.append(stack.last!.label)
    }
    return String(result)
  }

  func parseCratesAndInstructions(_ input: [String]) -> (CrateStacks, [CraneOperation]) {
    let (crateInput, instructionsInput) = splitInput(input)
    let operations = instructionsInput.map({CraneOperation($0)})
    return (parseCrateStacks(crateInput), operations)
  }
  
  func parseCrateStacks(_ crateInput: [String]) -> CrateStacks {
    // Each stack takes 4 characters, except the last whcih takes 3
    // NOTE: This assumes that each line is padded with whitespace, even
    // if there aren't any remaining crates on the line.
    let numStacks = (crateInput.first!.count + 1) / 4
    var stacks: [[Crate]] = []
    for _ in 0..<numStacks { stacks.append([]) }

    for line in crateInput {
      for stackNum in 0..<numStacks {
        let crateIdx = line.index(line.startIndex, offsetBy: stackNum * 4 + 1)
        if line[crateIdx] != " " {
          stacks[stackNum].insert(Crate(label: line[crateIdx]), at: 0)
        }
      }
    }
    
    return CrateStacks(stacks: stacks)
  }
  
  private func splitInput(_ input: [String]) -> ([String], [String]) {
    let divider = input.firstIndex(of: "")!
    
    let crateInput = input[..<(divider-1)]
    let instructionsInput = input[(divider+1)...].filter({!$0.isEmpty})
    return (Array(crateInput), Array(instructionsInput))
  }
}

struct Crate {
  let label: Character
}

struct CrateStacks {
  // Element 0 is the bottom of the stack
  let stacks: [[Crate]]
}

extension CrateStacks {
  func applyOperation(_ operation: CraneOperation) -> CrateStacks {
    var origStacks = self.stacks
    
    for _ in 0..<operation.count {
      // Stacks are 1-based indexed in the input
      let toMove = origStacks[operation.fromStack-1].popLast()!
      origStacks[operation.toStack-1].append(toMove)
    }
    
    return CrateStacks(stacks: origStacks)
  }
  
  // Applies the crane operation using the "CraneMover 9001" which
  // can pick up multiple crates at once (i.e. preserves stack ordering
  // across moves).
  func applyAdvancedOperation(_ operation: CraneOperation) -> CrateStacks {
    var stacks = self.stacks
    
    var tmp: [Crate] = []
    for _ in 0..<operation.count {
      tmp.append(stacks[operation.fromStack-1].popLast()!)
    }
    for _ in 0..<operation.count {
      stacks[operation.toStack-1].append(tmp.popLast()!)
    }
    
    return CrateStacks(stacks: stacks)
  }
}

struct CraneOperation {
  let count: Int
  let fromStack: Int
  let toStack: Int
}

extension CraneOperation {
  init(_ inputLine: String) {
    let instructionFormat = /move (\d+) from (\d+) to (\d+)/
    let match = inputLine.firstMatch(of: instructionFormat)!
    count = Int(match.1)!
    fromStack = Int(match.2)!
    toStack = Int(match.3)!
  }
}
