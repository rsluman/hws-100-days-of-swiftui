//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Roelf Sluman on 15/07/2024.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    ZStack {

      VStack(spacing: 0) {
        Color.red
        Color.blue
      }
      
      Text("Your Content")
        .foregroundStyle(.secondary)
        .padding(50)
        .background(.ultraThinMaterial)
        .cornerRadius(15)
      
    }.ignoresSafeArea()
  }
}

#Preview {
  ContentView()
}
