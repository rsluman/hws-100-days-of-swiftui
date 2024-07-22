//
//  ContentView.swift
//  Multiply
//
//  Created by Roelf Sluman on 22/07/2024.
//

import SwiftUI

enum GameState {
  case setup
  case playing
  case gameOver
}

struct ContentView: View {
  let maxTableLimit = 12 // maxium number of tables
  let possibleQuestionCount = [5, 10, 20]
  let colors: [GameState : Color] = [
    .setup : .orange,
    .playing: .mint,
    .gameOver: .green
  ]
  
  @State private var gameState = GameState.setup
  @State private var highestTable = 2 // highest table to practice
  @State private var numberOfQuestions = 5 // number of questions for this game
  
  @State private var currentQuestion = 0 // current question in this game
  @State private var multiplicand = 0
  @State private var multiplier = 0
  @State private var answer: Int?
  @State private var score = 0
  
  var body: some View {
    NavigationStack {
      ZStack {
        LinearGradient(colors: [colors[gameState]!, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing)
          .ignoresSafeArea()
        
        switch gameState {
        case .setup:
          VStack(alignment: .leading) {
            Text("How difficult?")
              .font(.title)
            Stepper("Highest Table: \(highestTable)", value: $highestTable, in: 2...maxTableLimit)
              .padding(.bottom, 40)
            
            Text("How many Questions?")
              .font(.title)
            Picker("How Many Questions?", selection: $numberOfQuestions) {
              ForEach(possibleQuestionCount, id: \.self) {
                Text("\($0)")
              }
            }
            .pickerStyle(.segmented)
            .padding(.bottom, 40)
            
            HStack {
              Spacer()
              
              Button {
                gameState = .playing
              } label: {
                Label("Play!", systemImage: "play.circle.fill")
                  .padding(30)
                  .background(.blue)
                  .foregroundColor(.white)
                  .clipShape(.capsule)
                
              }
              Spacer()
            }
            Spacer()
          }
          .padding()
          
          
        case .playing:
          VStack {
            
          }
          
          
          
        case .gameOver:
          Text("\(gameState)")
        }
      }
      .navigationTitle("Multiply")
      .toolbar {
        Button("New Game") { gameState = .setup }
      }
    }
  }
  
  func startGame() {
    score = 0
    currentQuestion = 0
    
  }
  
  func nextRound() {
    if currentQuestion < numberOfQuestions {
      currentQuestion += 1
      makeQuestion()
    } else {
      gameState = .gameOver
    }
  }
  
  func makeQuestion() {
    multiplicand = Int.random(in: 1...10)
    multiplier = Int.random(in: 2...highestTable)
  }
  
  func processAnswer(_ answer: Int?) {
    guard let answer else { return } // no answer given
    
    if isCorrectAnswer(answer) {
      increaseScore()
      nextRound()
    }
  }
  
  func isCorrectAnswer(_ answer: Int) -> Bool {
    return answer == multiplicand * multiplier
  }
  
  func increaseScore() {
    score += maxTableLimit - 1
  }
  
  
}

#Preview {
  ContentView()
}
