/// Solution to Advent of Code 2022 Day 9.
///
/// https://adventofcode.com/2022/day/9

internal struct Day10: Day {
  func solvePart1(input: [String]) -> String {
    let register = executeCommands(input)
    let result = interestingSignals(forRegisterValues: register).reduce(0, +)
    return String(result)
  }

  func solvePart2(input: [String]) -> String {
    return "TODO"
  }

  private func executeCommands(_ commands: [String]) -> [Int] {
    var register = 1
    var cycles: [Int] = []
    for command in commands {
      if command.isEmpty { continue }
      if command == "noop" {
        cycles.append(register)
      } else {
        // addx takes two cycles; at the end of the first the
        // register still has the same value
        cycles.append(register)
        register += Int(command.components(separatedBy: " ")[1])!
        cycles.append(register)
      }
    }
    return cycles
  }

  private func interestingSignals(forRegisterValues register: [Int]) -> [Int] {
    var interesting: [Int] = []
    // *During* the 20th cycle is *after* the 19th cycle, which is index 18
    var idx = 18
    while idx < register.count {
      let signal = (idx + 2) * register[idx]
      interesting.append(signal)
      idx += 40
    }
    return interesting
  }
}
