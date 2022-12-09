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
    return "TODO"
  }
  
  func calculateRoundScore(oppentChoice: String, playerChoice: String) -> Int {
    let baseScores: [HandShape: Int] = [.rock: 1, .paper: 2, .scissors: 3]
    
    let opponent = createShape(choice: oppentChoice)!
    let player = createShape(choice: playerChoice)!
    
    let baseScore = baseScores[player]!
    return baseScore + outcomeSocre(outcome: play(opponent: opponent, player: player))
  }
  
  func createShape(choice: String) -> HandShape? {
    if choice == "A" || choice == "X" {
      return .rock
    }
    if choice == "B" || choice == "Y" {
      return .paper
    }
    if choice == "C" || choice == "Z" {
      return .scissors
    }

    print("ERROR: Invalid choice '\(choice)'")
    return nil
  }
  
  func play(opponent: HandShape, player: HandShape) -> RoundOutcome {
    if opponent == player {
      return .draw
    }
    
    if player == .rock {
      if opponent == .scissors {
        // rock beats scissors
        return .win
      } else {
        // rock loses to paper
        return .loss
      }
    }
    
    if player == .scissors {
      if opponent == .paper {
        // scissors beats paper
        return .win
      } else {
        // scissors loses to rock
        return .loss
      }
    }
    
    // player == .paper
    if opponent == .rock {
      // paper beats rock
      return .win
    } else {
      // paper loses to scissors
      return .loss
    }
  }
  
  func outcomeSocre(outcome: RoundOutcome) -> Int {
    switch outcome {
    case .win:
      return 6
    case .loss:
      return 0
    case .draw:
      return 3
    }
  }
}
