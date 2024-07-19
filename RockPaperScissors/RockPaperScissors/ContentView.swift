//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Roelf Sluman on 19/07/2024.
//

import SwiftUI

struct IsHidden: ViewModifier {
  var hidden: Bool
  
  func body(content: Content) -> some View {
    Group {
      if hidden {
        EmptyView()
      } else {
        content
      }
    }
  }
}

extension View {
  func isHidden(_ hidden: Bool) -> some View {
    self.modifier(IsHidden(hidden: hidden))
  }
}


struct ContentView: View {
  let possibleMoves = ["Rock", "Scissors", "Paper"]
  let maxRounds = 2
  
  @State var myMove = ""
  @State var shouldPlayerWin = true
  
  @State var round = 0
  @State var score = 0
  @State var isGameOver = false
  
  func isScoringMove(_ move: String) -> Bool {
    print("Player should win: \(shouldPlayerWin)")
    if isWinningPlayerMove(move) {
      return shouldPlayerWin
    } else {
      return !shouldPlayerWin
    }
  }
  
  func isWinningPlayerMove(_ playerMove: String) -> Bool {
    switch playerMove {
    case "Rock":
      return myMove == "Scissors"
    case "Paper":
      return myMove == "Rock"
    case "Scissors":
      return myMove == "Paper"
    default:
      return false // should never happen
    }
  }
  
  func reset() {
    round = 0
    score = 0
    isGameOver = false
    shouldPlayerWin = Bool.random()
    nextRound()
  }
  
  func nextRound() {
    if round < maxRounds {
      round += 1
      myMove = possibleMoves[Int.random(in: 0..<possibleMoves.count)]
      shouldPlayerWin.toggle()
    } else {
      isGameOver = true
    }
  }
  
  func processMove(_ move: String) {
    if isScoringMove(move) {
      score += 1
    }
    else {
      score = max(score - 1, 0)
    }
    
    nextRound()
  }
  
  var body: some View {
    VStack(spacing: 20) {
      Text("Your Score: \(score)")
      Text("You must \(shouldPlayerWin ? "win" : "lose") this round.")
        .foregroundStyle(shouldPlayerWin ? Color.green : Color.red)
      Text("My Move: \(myMove)")
      
      
      HStack(spacing: 20) {
        ForEach(possibleMoves, id: \.self) { move in
          Button {
            processMove(move)
          } label: {
            Text(move)
          }
          .isHidden(move == myMove)
        }
        
      }
    }
    .padding()
    
    .alert("Game Over", isPresented: $isGameOver) {
      Button(action: reset, label: {
        Text("OK")
      })
    } message: {
      Text("Your total score: \(score)")
    }
    
    .onAppear {
      reset()
    }
  }
}

#Preview {
  ContentView()
}
