//
//  ContentView.swift
//  Animations
//
//  Created by Roelf Sluman on 21/07/2024.
//

import SwiftUI

struct ContentView: View {
  
  @State private var isEnabled = false
  
  var body: some View {
    Button("Tap me") {
      isEnabled.toggle()
    }
    .frame(width: 200, height: 200)
    .background(isEnabled ? .blue : .red)
    .foregroundStyle(.white)
//    .animation(.default, value: isEnabled) // animate any modifiers before this / (or since the previous .animation)
    .animation(nil, value: isEnabled) // Don't animate any modifiers before this / (or since the previous .animation)
    .clipShape(.rect(cornerRadius: isEnabled ? 60 : 0))
    .animation(.easeIn(duration: 5), value: isEnabled) // pertains to .clipshape only!
  }
}

#Preview {
  ContentView()
}
