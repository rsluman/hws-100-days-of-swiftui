//
//  ContentView.swift
//  Moonshot
//
//  Created by Roelf Sluman on 23/07/2024.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationStack {
      List(0..<100) { row in
        NavigationLink("Row \(row)") {
          Text("Details for Row \(row)")
        }
      }
     
      .navigationTitle("SwiftUI")
    }
  }
}

#Preview {
  ContentView()
}
