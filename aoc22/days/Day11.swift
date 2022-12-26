/// Solution to Advent of Code 2022 Day 11.
///
/// https://adventofcode.com/2022/day/11

internal struct Day11: Day {
  func solvePart1(input: [String]) -> String {
    let monkeys = parseMonkeys(lines: input)
    let result = monkeyBusiness(
      forMonkeys: monkeys, afterRounds: 20, worryTransform: { Item(worryLevel: $0.worryLevel / 3) })
    return String(result)
  }

  func solvePart2(input: [String]) -> String {
    let monkeys = parseMonkeys(lines: input)
    let modAll = monkeys.map({ $0.tossTest.divisibleBy }).reduce(1, *)
    let result = monkeyBusiness(
      forMonkeys: monkeys, afterRounds: 10000,
      worryTransform: { Item(worryLevel: $0.worryLevel % modAll) })
    return String(result)
  }

  private func parseMonkeys(lines: [String]) -> [Monkey] {
    var lineIdx = 0
    var monkeys: [Monkey] = []
    while lineIdx < lines.count && !lines[lineIdx].isEmpty {
      monkeys.append(Monkey(monkeyInput: Array(lines[lineIdx..<lineIdx + 6])))
      lineIdx += 7
    }
    return monkeys
  }

  private func monkeyBusiness(
    forMonkeys: [Monkey], afterRounds rounds: Int, worryTransform: (Item) -> Item
  ) -> Int {
    var monkeys = forMonkeys
    for _ in 1...rounds {
      for monkeyIdx in monkeys.indices {
        let turnResult = monkeys[monkeyIdx].takeTurn(worryTransform)
        for (item, destMonkey) in turnResult {
          let destIdx = monkeys.firstIndex(where: { $0.number == destMonkey })!
          monkeys[destIdx].items.append(item)
        }
      }
    }
    return monkeys.monkeyBusiness()
  }
}

private struct Item: Hashable {
  var worryLevel: Int
}

private struct Monkey {
  let number: Int
  var items: [Item]
  var inspectCount = 0
  let operation: Operation
  let tossTest: TossTest

  init(monkeyInput: [String]) {
    number = Int(monkeyInput[0].firstMatch(of: /Monkey (\d+):/)!.1)!
    items = Monkey.parseItems(fromLine: monkeyInput[1])
    operation = Operation(fullLine: monkeyInput[2])
    tossTest = TossTest(
      testLine: monkeyInput[3], trueLine: monkeyInput[4], falseLine: monkeyInput[5])
  }

  private static func parseItems(fromLine fullLine: String) -> [Item] {
    var items: [Item] = []
    let numbersStr = fullLine.components(separatedBy: ": ").last!
    var idx = 0
    while idx < numbersStr.count {
      // NOTE: Our input happens to consist of items with exactly 2 digit worry levels.
      let start = numbersStr.index(numbersStr.startIndex, offsetBy: idx)
      let end = numbersStr.index(start, offsetBy: 2)
      items.append(Item(worryLevel: Int(numbersStr[start..<end])!))
      // Two characters for the number we read plus two for the ", "
      idx += 4
    }
    return items
  }

  // Return a tuple list to preserve ordering that would get lost in a dictionary
  mutating func takeTurn(_ worryTransform: (Item) -> Item) -> [(Item, Int)] {
    var turnThrows: [(Item, Int)] = []
    for item in items {
      inspectCount += 1
      let newItem = worryTransform(operation.apply(to: item))
      turnThrows.append((newItem, tossTest.apply(to: newItem)))
    }
    // Every item gets thrown, so clear the items this monkey is holding
    items = []
    return turnThrows
  }
}

private struct Operation {
  let factor: Int?
  let opType: OperationType
  enum OperationType {
    case multiply, add
  }

  init(fullLine: String) {
    let suffix = fullLine.components(separatedBy: "= old ").last!
    opType = suffix[suffix.startIndex] == "*" ? .multiply : .add
    factor = Int(suffix.components(separatedBy: " ").last!)
  }

  func apply(to item: Item) -> Item {
    // factor == nil implies item's old value is both operands,
    // e.g. "new = old * old".
    let realFactor = factor ?? item.worryLevel
    switch opType {
    case .multiply:
      return Item(worryLevel: item.worryLevel * realFactor)
    case .add:
      return Item(worryLevel: item.worryLevel + realFactor)
    }
  }
}

private struct TossTest {
  let divisibleBy: Int
  private let trueToss: Int
  private let falseToss: Int

  init(testLine: String, trueLine: String, falseLine: String) {
    divisibleBy = Int(testLine.components(separatedBy: "divisible by ").last!)!
    trueToss = Int(trueLine.components(separatedBy: "If true: throw to monkey ").last!)!
    falseToss = Int(falseLine.components(separatedBy: "If false: throw to monkey ").last!)!
  }

  func apply(to item: Item) -> Int {
    return item.worryLevel % divisibleBy == 0 ? trueToss : falseToss
  }
}

extension Sequence where Element == Monkey {
  subscript(id: Int) -> Monkey {
    return self.filter({ $0.number == id }).first!
  }

  func monkeyBusiness() -> Int {
    return Array(self.map({ $0.inspectCount }).sorted().reversed()[..<2]).reduce(1, *)
  }

  func printInspectCounts() {
    for monkey in self {
      print("Monkey \(monkey.number): \(monkey.inspectCount)")
    }
    print()
  }
}
