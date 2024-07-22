//
//  ContentView.swift
//  Multiply
//
//  Created by Roelf Sluman on 22/07/2024.
//

import SwiftUI

extension Color {
  static var customGreen: Color {
    Color(UIColor(_colorLiteralRed: 0.2, green: 0.6, blue: 0.1, alpha: 1))
  }
  
}
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
  @State private var highestTableSelected = 2 // highest table to practice
  @State private var numberOfQuestions = 5 // number of questions for this game
  
  @State private var currentQuestion = 0 // current question
  @State private var multiplicand = 0
  @State private var multiplier = 0
  @State private var answer = "" // current answer
  @State private var submittedAnswers = [Bool]() // true: answer was correct
  @State private var score = 0
  
  @FocusState private var isKeyboardFocused: Bool
  
  var body: some View {
    NavigationStack {
      ZStack {
        LinearGradient(colors: [colors[gameState]!, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing)
          .ignoresSafeArea()
        
        switch gameState {
        case .setup:
          setupView
          
        case .playing:
          playingView
          
        case .gameOver:
          gameOverView
        }
      }
      .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/, value: gameState)

      .navigationTitle("Multiply")
      .toolbar {
        Button("New Game", action: setupGame)
      }
    }
  }
  
  @ViewBuilder var setupView: some View {
    VStack(alignment: .leading) {
      Text("How good are you?")
        .font(.title)
      Stepper("Game Levels: \(highestTableSelected)", value: $highestTableSelected, in: 2...maxTableLimit)
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
        
        StartButton(action: startGame)
        
        Spacer()
      }
      Spacer()
    }
    .padding()
  }
  
  @ViewBuilder var playingView: some View {
    VStack {
      progressBar
      
      
      HStack {
        Spacer()
        Text("\(multiplicand) x \(multiplier) =")
          .font(.largeTitle)
        TextField("Your answer?", text: $answer)
          .focused($isKeyboardFocused)
          .keyboardType(.numberPad)
          .font(.largeTitle)
          .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
              Spacer()
              Button("Done") {
                processAnswer()
              }
              .disabled(answer == "")
            }
          }
        
          .onSubmit(processAnswer)
        
        
        Spacer()
      }
      .padding()
      
      Spacer()
      Text("Your Score: \(score)")
        .font(.title)
    }
    .padding()
  }
  
  @ViewBuilder var gameOverView: some View {
    VStack {
      progressBar
      Spacer()
      Text("Your Score: \(score)")
        .font(.largeTitle)
      Spacer()
      Text("How about another one?")
        .font(.title3)
      StartButton(action: setupGame)
    }
  }
  
  @ViewBuilder var progressBar: some View {
    HStack {
      ForEach(1...numberOfQuestions, id: \.self) { question in
        Rectangle()
        .fill(progressBarItemColorForQuestion(question))
        .clipShape(Capsule())
        .scaleEffect(CGSize(width: 1.0, height: (question == currentQuestion ? 2.0 : 1.0) ))
        .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/, value: currentQuestion)
      }
    }
    .frame(height: 20)
    .padding()
  }
  
  func progressBarItemColorForQuestion(_ question: Int) -> Color {
    if question == currentQuestion {
      return .yellow
    } else if question > currentQuestion {
      return .gray
    } else {
      // answer has already been given
      return submittedAnswers[question - 1] ? .customGreen : .red
    }
  }
  
  func setupGame() {
    gameState = .setup
    isKeyboardFocused = false
  }
  
  func startGame() {
    gameState = .playing
    score = 0
    currentQuestion = 0
    nextRound()
  }
  
  func nextRound() {
    isKeyboardFocused = true
    currentQuestion += 1
    if currentQuestion <= numberOfQuestions {
      makeQuestion()
    } else {
      isKeyboardFocused = false
      gameState = .gameOver
    }
  }
  
  func makeQuestion() {
    answer = ""
    multiplicand = Int.random(in: 1...10)
    multiplier = Int.random(in: 2...highestTableSelected)
  }
  
  func processAnswer() {
    guard !answer.isEmpty else { return } // no answer given
    
    guard let answer = Int(answer) else {
      answer = ""
      return
    } // no int value
    
    if isCorrectAnswer(answer) {
      submittedAnswers.append(true)
      increaseScore()
      nextRound()
    } else {
      // still to come: wrong answer!
      submittedAnswers.append(false)
      nextRound()
    }
  }
  
  func isCorrectAnswer(_ answer: Int) -> Bool {
    return answer == multiplicand * multiplier
  }
  
  func increaseScore() {
    withAnimation(.easeInOut) {
      score += (highestTableSelected - 1)
    }
  }
  
}

struct StartButton: View {
  var action: () -> (Void)
  
  var body: some View {
    Button(action: action) {
      Label("Play!", systemImage: "play.circle.fill")
        .padding(30)
        .background(.blue)
        .foregroundColor(.white)
        .clipShape(.capsule)
    }
  }
}

#Preview {
  ContentView()
}

