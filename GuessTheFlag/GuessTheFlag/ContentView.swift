//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Roelf Sluman on 15/07/2024.
//

import SwiftUI

struct FlagImage: View {
  var country: String
  
  var body: some View {
    Image(country)
      .clipShape(Capsule())
      .shadow(radius: 5)
  }
}

struct ContentView: View {
  @State private var countries = [
    "Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
  
  @State private var correctAnswer = Int.random(in: 0...2) // random getal: 0, 1 of 2
  
  @State private var isShowingScore = false
  @State private var scoreTitle = ""
  @State private var scoreMessage = ""
  
  @State private var score = 0
  
  @State private var round = 1
  @State private var isGameOver = false
  
  @State private var flagToAnimate: Int?
  @State private var rotationAmounts = [0.0, 0.0, 0.0] // ééntje voor elke vlag
  
  let maxRounds = 8
  let gameOverTitle = "Game Over!"
  
  
  var body: some View {
    ZStack {
      RadialGradient(stops: [
        .init(color: .mutedBlue, location: 0.3),
        .init(color: .mutedRed, location: 0.3)
      ], center: .top, startRadius: 200, endRadius: 700)
      .ignoresSafeArea()
      
      VStack {
        Spacer()
        
        Text("Guess the Flag")
          .font(.largeTitle.bold())
          .foregroundColor(.white)
        
        VStack(spacing: 15) {
          VStack {
            Text("Tap the flag of")
              .foregroundStyle(.secondary)
              .font(.subheadline.weight(.heavy))
            
            Text(countries[correctAnswer])
              .font(.largeTitle.weight(.semibold))
          }
          
          ForEach(0..<3) { number in
            Button {
              flagToAnimate = number
              rotationAmounts[number] += 360
              print(rotationAmounts)
              flagTapped(number)
            } label: {
              FlagImage(country: countries[number])
                .rotation3DEffect(
                  .degrees(flagToAnimate == number ? rotationAmounts[number] : 0),
                                        axis: (x: 0.0, y: 1.0, z: 0.0)
                )
                
            }
            
            
          }
          
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        
        .background(.regularMaterial)
        .clipShape(.rect(cornerRadius: 20))
        
        Spacer()
        Spacer()
        
        Text("Score: \(score)")
          .font(.title.bold())
          .foregroundStyle(.white)
        
        Spacer()
        
      }
      .padding()
    }
    .alert(scoreTitle, isPresented: $isShowingScore) {
      Button("Continue", action: nextRound)
    } message: {
      Text(scoreMessage)
    }
    
    .alert(gameOverTitle, isPresented: $isGameOver) {
      Button("New Game", action: resetGame)
    } message: {
      Text("Your Final Score: \(score)")
    }
    
    
  }
  
  func flagTapped(_  number: Int) {
    score = number == correctAnswer ? score + 1 : max(score - 1, 0)
    
    if number == correctAnswer {
      scoreTitle = "😊 Correct!"
      scoreMessage = "Your score: \(score)."
    } else {
      
      scoreTitle = "🙁 Wrong"
      scoreMessage = "That is the flag of \(countries[number])."
    }
    
    isShowingScore = true
  }
  
  func nextRound() {
    if round < maxRounds {
      round += 1
      askQuestion()
    } else {
      isGameOver = true
    }
  }
  
  func askQuestion() {
    countries.shuffle()
    correctAnswer = Int.random(in: 0...2)
  }
  
  func resetGame() {
    round = 0
    score = 0
    nextRound()
  }
}

extension Color {
  static let mutedBlue = Color(red: 0.1, green: 0.2, blue: 0.45)
  static let mutedRed = Color(red: 0.76, green: 0.15 , blue: 0.26)
}

#Preview {
  ContentView()
}
