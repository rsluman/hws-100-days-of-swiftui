//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Roelf Sluman on 17/07/2024.
//

import SwiftUI

// Run in simulator, not in Canvas
struct ContentView: View {
  var body: some View {
    VStack {
      Text("1")
      Text("2")
    }
    Text("Hello")
    Text ("World!")
    Button("Hello, World!") {
      print(type(of: self.body))
      // TupleView<(Text, Text, Button<Text>)>
    }
  }
}

struct TupleViewDemoView: View {
  var body: some View {
    TupleView(
      (Text("Item 1"),
       Text("Item 2"),
       Text("Item 3")))
  }
}

#Preview {
//  ContentView()
  TupleViewDemoView()
}
