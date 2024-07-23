//
//  ContentView.swift
//  iExpense
//
//  Created by Roelf Sluman on 22/07/2024.
//

import SwiftUI

struct ContentView: View {
  @AppStorage("tapCount") private var tapCount = 0
  
  var body: some View {
    Button("Tap Count: \(tapCount)") {
      tapCount += 1
    }
  }
}

#Preview {
  ContentView()
}
