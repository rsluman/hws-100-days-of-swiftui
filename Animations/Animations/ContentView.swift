//
//  ContentView.swift
//  Animations
//
//  Created by Roelf Sluman on 21/07/2024.
//

import SwiftUI

struct ContentView: View {
  
  @State private var animationAmount = 0.0
  
  var body: some View {
    Button("Tap me") {
      withAnimation(.easeInOut.speed(0.1).repeatForever(autoreverses: false)) {
        animationAmount += 360
      }
    }
    .padding(50)
    .background(.red)
    .foregroundStyle(.white)
    .clipShape(.circle)
    .rotation3DEffect(.degrees(animationAmount), axis: (x: 0.0, y: 1.0, z: 0.0))
  }
}

#Preview {
  ContentView()
}
