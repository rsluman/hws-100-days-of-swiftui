//
//  ContentView.swift
//  Animations
//
//  Created by Roelf Sluman on 21/07/2024.
//

import SwiftUI

struct ContentView: View {
  let letters = Array("Hello SwiftUI")
  
  @State private var isEnabled = false
  @State private var dragAmount = CGSize.zero
  
  var body: some View {
    HStack(spacing: 0) {
      ForEach(0..<letters.count, id: \.self) { num in
        Text(String(letters[num]))
          .padding(5)
          .font(.largeTitle)
          .background(isEnabled ? .blue : .red)
          .offset(dragAmount)
          .animation(.linear.delay(Double(num) / 20), value: dragAmount)
      }
    }
    .gesture(
      DragGesture()
        .onChanged() { dragAmount = $0.translation }
        .onEnded() { _ in
          isEnabled.toggle()
          dragAmount = CGSize.zero
        }
    )
  }
}

#Preview {
  ContentView()
}
