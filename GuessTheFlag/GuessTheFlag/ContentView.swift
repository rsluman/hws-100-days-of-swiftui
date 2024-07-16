//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Roelf Sluman on 15/07/2024.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    //    Button("Edit", systemImage: "circle.square") { }
    
    Button(action: executePlay) {
      Label {
        Text("Play") } icon: {
          Image(systemName: "gamecontroller")
            .font(.largeTitle)
        }
    }
    .foregroundStyle(Gradient(colors: [.red, .yellow]))

  }
  
  func executePlay() {
    print("Now playing...")
  }
}

#Preview {
  ContentView()
}
