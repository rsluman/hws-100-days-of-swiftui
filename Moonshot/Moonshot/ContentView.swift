//
//  ContentView.swift
//  Moonshot
//
//  Created by Roelf Sluman on 23/07/2024.
//

import SwiftUI

struct ContentView: View {
  let layout = [
    GridItem(.adaptive(minimum: 80))
  ]
  
  var body: some View {
    ScrollView {
      LazyVGrid(columns: layout) {
        ForEach(0..<1000) {
          Text("Item \($0)")
        }
      }
      .padding()
    }
  }
}


#Preview {
  ContentView()
}
