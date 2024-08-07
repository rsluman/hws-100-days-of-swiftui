//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Roelf Sluman on 17/07/2024.
//

import SwiftUI

struct ProminentTitle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.largeTitle)
      .foregroundColor(.blue)
  }
}

extension View {
  var prominentTitle: some View {
    return self.modifier(ProminentTitle())
  }
}

struct GridStack<Content: View>: View {
  let rows: Int
  let columns: Int
  let content: (Int, Int) -> Content
  
  var body: some View {
    ForEach(0..<rows, id: \.self) { row in
      VStack(spacing: 10) {
        HStack(spacing: 10) {
          ForEach(0..<columns, id: \.self) { column in
            content(row, column)
          }
        }
      }
    }
  }
}

struct ContentView: View {
  let colors: [Color] = [
    .green, .blue, .red, .yellow, .purple, .brown, .indigo, .mint, .orange
  ]
  
  var body: some View {
    VStack(spacing: 10) {
      Text("GridStack & Custom Modifier")
        .prominentTitle
      GridStack(rows: 3, columns: 3) { row, column in
        Color(colors[row * 3 + column])
      }
      .padding()
    }
  }
}

#Preview {
  ContentView()
}
