//
//  ContentView.swift
//  Animations
//
//  Created by Roelf Sluman on 21/07/2024.
//

import SwiftUI

struct ContentView: View {
  @State private var animationAmount = 1.0
  
  var body: some View {
    Button("Tap Me!") {
//      withAnimation(.spring(duration: 1, bounce: 0.9)) {
        animationAmount += 1
//      }
    }
    .padding(50)
    .background(.red)
    .foregroundStyle(.white)
    .clipShape(Circle())
    .scaleEffect(animationAmount)
    .blur(radius: (animationAmount - 1) * 3)
//    .animation(.spring(duration: 1, bounce: 0.9), value: animationAmount)
//    .animation(.easeInOut(duration: 2), value: animationAmount)
//    .animation(.easeInOut(duration: 2).delay(1), value: animationAmount)
//    .animation(.easeInOut(duration: 2).repeatCount(3, autoreverses: true), value: animationAmount)
    .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: animationAmount)
  }
}

#Preview {
  ContentView()
}
