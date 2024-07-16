//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Roelf Sluman on 15/07/2024.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    Button {
      print("Button was tapped")
    } label: {
      Text("Press here...")
        .padding()
        .foregroundStyle(.white)
        .background(.red)
        .cornerRadius(10)
    }
  }
  
  func executeDelete() {
    print("Now deleting...")
  }
}

#Preview {
  ContentView()
}
