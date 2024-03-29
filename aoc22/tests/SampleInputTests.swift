/// Unit tests to verify sample inputs.
import XCTest

final class SampleInputTests: XCTestCase {

  private func sampleInputTest(
    _ day: Day, _ input: [String], part1Answer: String, part2Answer: String?
  ) {
    XCTAssertEqual(day.solvePart1(input: input), part1Answer)
    if let part2Answer = part2Answer {
      XCTAssertEqual(day.solvePart2(input: input), part2Answer)
    }
  }

  func testDay1() throws {
    let input =
      """
      1000
      2000
      3000

      4000

      5000
      6000

      7000
      8000
      9000

      10000
      """.components(separatedBy: "\n")
    sampleInputTest(Day01(), input, part1Answer: "24000", part2Answer: "45000")
  }

  func testDay2() throws {
    let input = ["A Y", "B X", "C Z"]
    sampleInputTest(Day02(), input, part1Answer: "15", part2Answer: "12")
  }

  func testDay3() throws {
    let input =
      """
      vJrwpWtwJgWrhcsFMMfFFhFp
      jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
      PmmdzqPrVvPwwTWBwg
      wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
      ttgJtRGJQctTZtZT
      CrZsJsPPZsGzwwsLwLmpwMDw
      """.components(separatedBy: "\n")
    sampleInputTest(Day03(), input, part1Answer: "157", part2Answer: "70")
  }

  func testDay4() throws {
    let input =
      """
      2-4,6-8
      2-3,4-5
      5-7,7-9
      2-8,3-7
      6-6,4-6
      2-6,4-8
      """.components(separatedBy: "\n")
    sampleInputTest(Day04(), input, part1Answer: "2", part2Answer: "4")
  }

  func testDay5() throws {
    let input = [
      "    [D]    ",
      "[N] [C]    ",
      "[Z] [M] [P]",
      " 1   2   3 ",
      "",
      "move 1 from 2 to 1",
      "move 3 from 1 to 3",
      "move 2 from 2 to 1",
      "move 1 from 1 to 2",
    ]
    sampleInputTest(Day05(), input, part1Answer: "CMZ", part2Answer: "MCD")
  }

  func testDay6() throws {
    let input = ["mjqjpqmgbljsphdztnvjfqwrcgsmlb"]
    sampleInputTest(Day06(), input, part1Answer: "7", part2Answer: "19")
  }

  func testDay7() throws {
    let input =
      """
      $ cd /
      $ ls
      dir a
      14848514 b.txt
      8504156 c.dat
      dir d
      $ cd a
      $ ls
      dir e
      29116 f
      2557 g
      62596 h.lst
      $ cd e
      $ ls
      584 i
      $ cd ..
      $ cd ..
      $ cd d
      $ ls
      4060174 j
      8033020 d.log
      5626152 d.ext
      7214296 k
      """.components(separatedBy: "\n")
    sampleInputTest(Day07(), input, part1Answer: "95437", part2Answer: nil)
  }

  func testDay8() throws {
    let input =
      """
      30373
      25512
      65332
      33549
      35390
      """.components(separatedBy: "\n")
    sampleInputTest(Day08(), input, part1Answer: "21", part2Answer: "8")
  }

  func testDay9() throws {
    let input =
      """
      R 4
      U 4
      L 3
      D 1
      R 4
      D 1
      L 5
      R 2
      """.components(separatedBy: "\n")
    sampleInputTest(Day09(), input, part1Answer: "13", part2Answer: nil)
  }

  func testDay11() throws {
    let input =
      """
      Monkey 0:
      Starting items: 79, 98
      Operation: new = old * 19
      Test: divisible by 23
      If true: throw to monkey 2
      If false: throw to monkey 3

      Monkey 1:
      Starting items: 54, 65, 75, 74
      Operation: new = old + 6
      Test: divisible by 19
      If true: throw to monkey 2
      If false: throw to monkey 0

      Monkey 2:
      Starting items: 79, 60, 97
      Operation: new = old * old
      Test: divisible by 13
      If true: throw to monkey 1
      If false: throw to monkey 3

      Monkey 3:
      Starting items: 74
      Operation: new = old + 3
      Test: divisible by 17
      If true: throw to monkey 0
      If false: throw to monkey 1
      """.components(separatedBy: "\n")
    sampleInputTest(Day11(), input, part1Answer: "10605", part2Answer: "2713310158")
  }

  func testDay12() throws {
    let input =
      """
      Sabqponm
      abcryxxl
      accszExk
      acctuvwj
      abdefghi
      """.components(separatedBy: "\n")
    sampleInputTest(Day12(), input, part1Answer: "31", part2Answer: "29")
  }

  func testDay13() throws {
    let input =
      """
      [1,1,3,1,1]
      [1,1,5,1,1]

      [[1],[2,3,4]]
      [[1],4]

      [9]
      [[8,7,6]]

      [[4,4],4,4]
      [[4,4],4,4,4]

      [7,7,7,7]
      [7,7,7]

      []
      [3]

      [[[]]]
      [[]]

      [1,[2,[3,[4,[5,6,7]]]],8,9]
      [1,[2,[3,[4,[5,6,0]]]],8,9]
      """.components(separatedBy: "\n")
    sampleInputTest(Day13(), input, part1Answer: "13", part2Answer: "140")
  }

  func testDay14() throws {
    let input =
      """
      498,4 -> 498,6 -> 496,6
      503,4 -> 502,4 -> 502,9 -> 494,9
      """.components(separatedBy: "\n")
    sampleInputTest(Day14(), input, part1Answer: "24", part2Answer: "93")
  }

  func testDay15() throws {
    let input =
      """
      Sensor at x=2, y=18: closest beacon is at x=-2, y=15
      Sensor at x=9, y=16: closest beacon is at x=10, y=16
      Sensor at x=13, y=2: closest beacon is at x=15, y=3
      Sensor at x=12, y=14: closest beacon is at x=10, y=16
      Sensor at x=10, y=20: closest beacon is at x=10, y=16
      Sensor at x=14, y=17: closest beacon is at x=10, y=16
      Sensor at x=8, y=7: closest beacon is at x=2, y=10
      Sensor at x=2, y=0: closest beacon is at x=2, y=10
      Sensor at x=0, y=11: closest beacon is at x=2, y=10
      Sensor at x=20, y=14: closest beacon is at x=25, y=17
      Sensor at x=17, y=20: closest beacon is at x=21, y=22
      Sensor at x=16, y=7: closest beacon is at x=15, y=3
      Sensor at x=14, y=3: closest beacon is at x=15, y=3
      Sensor at x=20, y=1: closest beacon is at x=15, y=3
      """.components(separatedBy: "\n")
    let day = Day15(rowOfInterest: 10, searchRestriction: 20)
    sampleInputTest(day, input, part1Answer: "26", part2Answer: "56000011")
  }

  func testDay16() throws {
    let input =
      """
      Valve AA has flow rate=0; tunnels lead to valves DD, II, BB
      Valve BB has flow rate=13; tunnels lead to valves CC, AA
      Valve CC has flow rate=2; tunnels lead to valves DD, BB
      Valve DD has flow rate=20; tunnels lead to valves CC, AA, EE
      Valve EE has flow rate=3; tunnels lead to valves FF, DD
      Valve FF has flow rate=0; tunnels lead to valves EE, GG
      Valve GG has flow rate=0; tunnels lead to valves FF, HH
      Valve HH has flow rate=22; tunnel leads to valve GG
      Valve II has flow rate=0; tunnels lead to valves AA, JJ
      Valve JJ has flow rate=21; tunnel leads to valve II
      """.components(separatedBy: "\n")
    sampleInputTest(Day16(), input, part1Answer: "1651", part2Answer: "1707")
  }

  func testDay17() throws {
    let input = [">>><<><>><<<>><>>><<<>>><<<><<<>><>><<>>", ""]
    sampleInputTest(Day17(), input, part1Answer: "3068", part2Answer: "1514285714288")
  }

  func testDay18() throws {
    let input =
      """
      2,2,2
      1,2,2
      3,2,2
      2,1,2
      2,3,2
      2,2,1
      2,2,3
      2,2,4
      2,2,6
      1,2,5
      3,2,5
      2,1,5
      2,3,5
      """.components(separatedBy: "\n")
    sampleInputTest(Day18(), input, part1Answer: "64", part2Answer: "58")
  }
}
