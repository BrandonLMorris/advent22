/// Solution to Advent of Code 2022 Day 8.
///
/// https://adventofcode.com/2022/day/8

internal struct Day08: Day {
  func solvePart1(input: [String]) -> String {
    return String(Forest(input).visible)
  }

  func solvePart2(input: [String]) -> String {
    return "TODO"
  }
}

private struct Forest {
  let trees: [[Int]]
  var visible: Int {
    // Tally up all the true elements in the visibility matrix
    return visibility.map({ $0.filter({ $0 }).count }).reduce(0, +)
  }

  private var visibility: [[Bool]]

  init(_ input: [String]) {
    var rows: [[Int]] = []
    for line in input {
      if line.isEmpty { continue }
      rows.append(line.map({ Int(String($0))! }))
    }
    trees = rows
    visibility = Forest.initVisibility(withSize: trees.count)
    updateVisibility()
  }

  private static func initVisibility(withSize size: Int) -> [[Bool]] {
    var matrix: [[Bool]] = []
    for row in 0..<size {
      var matrixRow: [Bool] = []
      for _ in 0..<size {
        matrixRow.append(false)
      }
      // The first and last tree of each row is visible
      matrixRow[0] = true
      matrixRow[size - 1] = true

      // The first and last rows are all visible
      if row == 0 || row == size - 1 {
        for idx in 0..<size - 1 {
          matrixRow[idx] = true
        }
      }
      matrix.append(matrixRow)
    }
    return matrix
  }

  private mutating func updateVisibility() {
    for idx in 1..<trees.count - 1 {
      horizontalTraversal(&visibility, forRow: idx)
      verticalTraversal(&visibility, forCol: idx)
    }
  }

  private func horizontalTraversal(_ visibility: inout [[Bool]], forRow row: Int) {
    let treeRow = trees[row]

    // Left to right
    var tallestSoFar = treeRow[0]
    for idx in 1..<trees.count - 1 {
      if treeRow[idx] > tallestSoFar {
        visibility[row][idx] = true
        tallestSoFar = trees[row][idx]
      }
    }

    // Right to left
    tallestSoFar = treeRow[treeRow.count - 1]
    for offset in 1..<trees.count - 1 {
      let idx = (treeRow.count - 1) - offset
      if treeRow[idx] > tallestSoFar {
        visibility[row][idx] = true
        tallestSoFar = trees[row][idx]
      }
    }
  }

  private func verticalTraversal(_ visibility: inout [[Bool]], forCol col: Int) {
    // Top to bottom
    var tallestSoFar = trees[0][col]
    for row in 1..<trees.count - 1 {
      if trees[row][col] > tallestSoFar {
        visibility[row][col] = true
        tallestSoFar = trees[row][col]
      }
    }

    // Bottom to top
    tallestSoFar = trees[trees.count - 1][col]
    for rowOffset in 1..<trees.count - 1 {
      let row = (trees.count - 1) - rowOffset
      if trees[row][col] > tallestSoFar {
        visibility[row][col] = true
        tallestSoFar = trees[row][col]
      }
    }
  }
}
