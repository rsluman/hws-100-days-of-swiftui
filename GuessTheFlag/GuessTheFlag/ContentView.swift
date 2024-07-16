//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Roelf Sluman on 15/07/2024.
//

import SwiftUI

struct ContentView: View {
  @State private var countries = [
    "Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
  
  @State private var correctAnswer = Int.random(in: 0...2) // random getal: 0, 1 of 2
  
  @State private var isShowingScore = false
  @State private var scoreTitle = ""
  
  @State private var score = 0
    
  var body: some View {
    ZStack {
      LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
        .ignoresSafeArea()
      VStack(spacing: 30) {
        VStack {
          Text("Tap the flag of")
            .font(.subheadline.weight(.bold))
          
          Text(countries[correctAnswer])
            .font(.largeTitle.weight(.semibold))
        }
        .foregroundStyle(.white)

        ForEach(0..<3) { number in
          Button {
            flagTapped(number)
          } label: {
            Image(countries[number])
              .clipShape(Capsule())
              .shadow(radius: 5)
          }

          
        }
        
      }
    }
    .alert(scoreTitle, isPresented: $isShowingScore) {
      Button("Continue", action: askQuestion)
    } message: {
      Text("Your score: \(score)")
    }

  }
  
  func flagTapped(_  number: Int) {
    scoreTitle = number == correctAnswer ? "😊 Correct!" : "🙁 Wrong"
    isShowingScore = true
    score = number == correctAnswer ? score + 1 : max(score - 1, 0)
  }
  
  func askQuestion() {
    countries.shuffle()
    correctAnswer = Int.random(in: 0...2)
  }
}

#Preview {
  ContentView()
}
