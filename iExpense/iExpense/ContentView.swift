//
//  ContentView.swift
//  iExpense
//
//  Created by Roelf Sluman on 22/07/2024.
//

import SwiftUI

struct ContentView: View {
  @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
  
  var body: some View {
    Button("Tap Count: \(tapCount)") {
      tapCount += 1
      UserDefaults.standard.setValue(tapCount, forKey: "Tap")
      
    }
  }
}

#Preview {
  ContentView()
}
