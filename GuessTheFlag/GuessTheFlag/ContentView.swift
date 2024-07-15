//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Roelf Sluman on 15/07/2024.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    MyGrid()
    Spacer()
  }
}


struct MyGrid: View {
  var body: some View {
    VStack {
      ForEach(1..<4) { row in
        VStack {
          HStack(alignment: .top, spacing: 20) {
            ForEach(1..<4) { col in
              BlockText("\(row) - \(col)")
            }
          }
        }
      }
    }
  }
}

struct BlockText: View {
  var title: String
  
  init(_ title: String) {
    self.title = title
  }
  
  var body: some View {
    Text(title)
      .padding()
      .border(Color.black)
      .padding()
  }
}

#Preview {
  ContentView()
}
