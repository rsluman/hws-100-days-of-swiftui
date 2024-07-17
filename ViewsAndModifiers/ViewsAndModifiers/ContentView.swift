//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Roelf Sluman on 17/07/2024.
//

import SwiftUI

struct ContentView: View {
  @State private var isRed = false
  var body: some View {
    VStack(spacing: 20) {

      VStack(spacing: 20) {
        // Optimaal:
        
        Text("Demo (optimaal)")
          .foregroundStyle(isRed ? .red : .blue)
        
        // Suboptimaal: state-change -> een nieuwe View
        
        if isRed { // suboptimaal!
          Text("Demo (suboptimaal)")
            .foregroundColor(.red)
        } else {
          Text("Demo (suboptimaal)")
            .foregroundStyle(.blue)
        }
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(isRed ? .blue : .red)

      Button("Tap to Change Color") {
        isRed.toggle()
      }
      
    }
  }
}

#Preview {
  ContentView()
}
