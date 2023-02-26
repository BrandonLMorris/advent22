//
//  Day13.swift
//  aoc22
//
//  https://adventofcode.com/2022/day/13
//

internal struct Day13: Day {
  func solvePart1(input: [String]) -> String {
    let packetPairs = parsePacketPairs(input)
    var inOrderIndices: [Int] = []
    for (idx, packets) in packetPairs.enumerated() {
      if Packet.inOrder(packets.0, packets.1) {
        inOrderIndices.append(idx + 1)
      }
    }
    return String(inOrderIndices.reduce(0, +))
  }

  func solvePart2(input: [String]) -> String {
    var packets = parsePackets(input)
    let firstDivider = Packet(line: "[[2]]")
    let secondDivider = Packet(line: "[[6]]")
    packets.append(firstDivider)
    packets.append(secondDivider)

    packets.sort()

    let result =
      (packets.firstIndex(of: firstDivider)! + 1) * (packets.firstIndex(of: secondDivider)! + 1)

    return String(result)
  }

  private func parsePackets(_ input: [String]) -> [Packet] {
    var packets: [Packet] = []
    var lineIdx = 0
    var packetIdx = 1

    while lineIdx < input.count && !input[lineIdx].isEmpty {
      packets.append(Packet(line: input[lineIdx]))
      packets.append(Packet(line: input[lineIdx + 1]))

      // Two lines of packets plus one blank separating line
      lineIdx += 3
      packetIdx += 1
    }
    return packets
  }

  private func parsePacketPairs(_ input: [String]) -> [(Packet, Packet)] {
    let packets = parsePackets(input)
    var pairs: [(Packet, Packet)] = []
    for idx in stride(from: 0, to: packets.count, by: 2) {
      pairs.append((packets[idx], packets[idx + 1]))
    }
    return pairs
  }
}

private struct Packet: Comparable {
  private let contents: [PacketContents]

  init(line: String) {
    contents = [PacketContents(list: line)]
  }

  static func < (lhs: Packet, rhs: Packet) -> Bool {
    if let comparison = PacketContents.compare(
      lhs: .listValue(lhs.contents), rhs: .listValue(rhs.contents))
    {
      return comparison
    }
    // compare() returns nil if the contents are equal
    return false
  }

  static func == (lhs: Packet, rhs: Packet) -> Bool {
    return PacketContents.compare(lhs: .listValue(lhs.contents), rhs: .listValue(rhs.contents))
      == nil
  }

  static func inOrder(_ left: Packet, _ right: Packet) -> Bool {
    let leftContents = left.contents
    let rightContents = right.contents
    return PacketContents.compare(lhs: .listValue(leftContents), rhs: .listValue(rightContents))!
  }

  private enum PacketContents {
    case singleValue(Int)
    case listValue([PacketContents])

    init(list: String) {
      var contents: [PacketContents] = []
      let characters = Array(list)
      if characters[0] != "[" || characters[list.count - 1] != "]" {
        print("ERROR: Parsing list from values not enclosed in []: \(list)")
        self = .listValue([])
        return
      }

      var idx = 1
      while idx < list.count {
        // The current item is either a single element or a sublist
        if characters[idx] == "," {
          idx += 1
        } else if characters[idx] == "[" {
          // Keep reading until the matching closing bracket ]
          var endIdx = idx + 1
          var openBracketCount = 1
          while endIdx < list.count {
            if characters[endIdx] == "[" { openBracketCount += 1 }
            if characters[endIdx] == "]" {
              openBracketCount -= 1
              if openBracketCount == 0 { break }
            }
            endIdx += 1
          }
          // Parse the substring recursively
          let start = list.index(list.startIndex, offsetBy: idx)
          let end = list.index(list.startIndex, offsetBy: endIdx)
          let range = start...end
          contents.append(PacketContents(list: String(list[range])))
          idx = endIdx + 1
        } else if characters[idx] == "]" {
          // The end of the current list
          self = .listValue(contents)
          return
        } else {
          // Note: Inputs are always at most two digits
          if characters[idx + 1] == "," || characters[idx + 1] == "]" {
            contents.append(.singleValue(Int(String(characters[idx]))!))
            idx += 2
          } else {
            let valueStr = "\(characters[idx])\(characters[idx+1])"
            contents.append(.singleValue(Int(valueStr)!))
            idx += 3
          }
        }
      }

      self = .listValue(contents)
    }

    fileprivate static func compare(lhs: PacketContents, rhs: PacketContents) -> Bool? {
      switch lhs {
      case .singleValue(let leftValue):
        switch rhs {
        case .singleValue(let rightValue):
          return leftValue == rightValue ? nil : leftValue < rightValue
        case .listValue:
          return compare(lhs: PacketContents.listValue([lhs]), rhs: rhs)
        }

      case .listValue(let leftList):
        switch rhs {
        case .singleValue:
          return compare(lhs: lhs, rhs: PacketContents.listValue([rhs]))
        case .listValue(let rightList):
          return compareLists(leftList, rightList)
        }
      }

      func compareLists(_ left: [PacketContents], _ right: [PacketContents]) -> Bool? {
        var idx = 0
        while idx < max(left.count, right.count) {
          if idx >= left.count {
            // Left list ran out of items first
            return true
          } else if idx >= right.count {
            // Right list ran out of items first
            return false
          }
          // If the comparison returns nil, the elements at this index are equal and
          // we need to continue comparing.
          if let compareResult = compare(lhs: left[idx], rhs: right[idx]) {
            return compareResult
          }

          idx += 1
        }

        // The full list elements are equal
        return nil
      }
    }
  }
}
