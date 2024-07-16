//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Roelf Sluman on 15/07/2024.
//

import SwiftUI

struct ContentView: View {
  @State var shouldShowAlert = false
  
  var body: some View {
    
    Button("Press!") { shouldShowAlert = true }
      .alert("Important Message", isPresented: $shouldShowAlert) {
        Button("Destroy", role: .destructive) { }
        Button("Cancel", role: .cancel) {}
      }
  }
}

#Preview {
  ContentView()
}
