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
              flagTapped(number)
            } label: {
              Image(countries[number])
                .clipShape(Capsule())
                .shadow(radius: 5)
            }
            
            
          }
          
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        
        .background(.regularMaterial)
      .clipShape(.rect(cornerRadius: 20))
        
        Spacer()
        Spacer()
        
        Text("Score: ???")
          .font(.title.bold())
          .foregroundStyle(.white)
        
        Spacer()
        
      }
      .padding()
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

extension Color {
  static let mutedBlue = Color(red: 0.1, green: 0.2, blue: 0.45)
  static let mutedRed = Color(red: 0.76, green: 0.15 , blue: 0.26)
}

#Preview {
  ContentView()
}
