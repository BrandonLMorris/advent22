// Solution to Advent of Code 2022 Day 2.
//
// https://adventofcode.com/2022/day/2

import Foundation

enum HandShape {
  case rock, paper, scissors
}

enum RoundOutcome {
  case win, loss, draw
}

// opponentChoice -> playerChoice where the player wins
let playerChoiceToWin: [HandShape: HandShape] = [
  .rock: .paper, .paper: .scissors, .scissors: .rock,
]
// opponentChoice -> playerChoice where the player loses
let playerChoiceToLose: [HandShape: HandShape] = [
  .paper: .rock, .scissors: .paper, .rock: .scissors,
]
let choiceToShape: [String: HandShape] = [
  "A": .rock, "X": .rock, "B": .paper, "Y": .paper, "C": .scissors, "Z": .scissors,
]
let playerChoiceScore: [HandShape: Int] = [.rock: 1, .paper: 2, .scissors: 3]
let outcomeToScore: [RoundOutcome: Int] =
  [
    .win: 6,
    .loss: 0,
    .draw: 3,
  ]

class Day02: Day {
  func solvePart1(input: [String]) -> String {
    var total = 0
    for roundLine in input {
      if roundLine.isEmpty { continue }
      let choices = roundLine.components(separatedBy: " ")
      total += calculateRoundScore(oppentChoice: choices[0], playerChoice: choices[1])
    }
    return String(total)
  }

  func solvePart2(input: [String]) -> String {
    var score = 0
    for roundLine in input {
      if roundLine.isEmpty { continue }
      let splitInput = roundLine.components(separatedBy: " ")
      let opponent = choiceToShape[splitInput[0]]!
      let inputToOutcome: [String: RoundOutcome] =
        [
          "X": .loss,
          "Y": .draw,
          "Z": .win,
        ]
      let outcome = inputToOutcome[splitInput[1]]!
      let player = determinePlayerForOutcome(opponent: opponent, outcome: outcome)
      score += playerChoiceScore[player]! + outcomeToScore[outcome]!
    }
    return String(score)
  }

  func calculateRoundScore(oppentChoice: String, playerChoice: String) -> Int {
    let opponent = choiceToShape[oppentChoice]!
    let player = choiceToShape[playerChoice]!

    return playerChoiceScore[player]! + outcomeToScore[play(opponent: opponent, player: player)]!
  }

  func play(opponent: HandShape, player: HandShape) -> RoundOutcome {
    if opponent == player {
      return .draw
    }

    if playerChoiceToWin[opponent] == player {
      return .win
    } else {
      return .loss
    }
  }

  func determinePlayerForOutcome(opponent: HandShape, outcome: RoundOutcome) -> HandShape {
    switch outcome {
    case .draw:
      return opponent
    case .win:
      return playerChoiceToWin[opponent]!
    case .loss:
      return playerChoiceToLose[opponent]!
    }
  }
}
