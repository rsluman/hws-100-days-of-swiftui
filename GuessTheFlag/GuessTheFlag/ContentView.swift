//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Roelf Sluman on 15/07/2024.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack(spacing: 20) {
      Button("Button 1") { }
        .buttonStyle(.bordered)
      
      Button("Button 2", role: .destructive) { }
        .buttonStyle(.bordered)

      Button("Button 3") { }
        .buttonStyle(.borderedProminent)
      
      Button("Button 4", role: .destructive) { }
        .buttonStyle(.borderedProminent)

      Button("Button 5") { }
        .buttonStyle(.bordered)
        .tint(.indigo)
      
      Button("Button 6") { }
        .buttonStyle(.borderedProminent)
        .tint(.indigo)

      Button("Delete selection") {
        executeDelete()
      }
    }
  }
  
  func executeDelete() {
    print("Now deleting...")
  }
}

#Preview {
  ContentView()
}
