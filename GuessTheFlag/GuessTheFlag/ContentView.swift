//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Roelf Sluman on 15/07/2024.
//

import SwiftUI

struct ContentView: View {
  var countries = [
    "Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"]
  
  var correctAnswer = Int.random(in: 0...2) // random getal: 0, 1 of 2
    
  var body: some View {
    ZStack {
      Color.blue
        .ignoresSafeArea()
      VStack(spacing: 30) {
        VStack {
          Text("Tap the flag of")
          Text(countries[correctAnswer])
        }
        .foregroundStyle(.white)

        ForEach(0..<3) { number in
          Button {
            // Flag was tapped
          } label: {
            Image(countries[number])
              .border(.secondary)
          }

          
        }
        
      }
    }
  }
}

#Preview {
  ContentView()
}
