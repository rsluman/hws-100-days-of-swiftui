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
    Button("Hello, World!") {
      print(type(of: self.body))
      // ModifiedContent<ModifiedContent<ModifiedContent<ModifiedContent<ModifiedContent<ModifiedContent<ModifiedContent<ModifiedContent<ModifiedContent<Button<Text>, _BackgroundStyleModifier<Color>>, _PaddingLayout>, _BackgroundStyleModifier<Color>>, _PaddingLayout>, _BackgroundStyleModifier<Color>>, _PaddingLayout>, _BackgroundStyleModifier<Color>>, _PaddingLayout>, _BackgroundStyleModifier<Color>>
    }
    .background(.red)
    .padding()
    .background(.green)
    .padding()
    .background(.blue)
    .padding()
    .background(.yellow)
    .padding()
    .background(.indigo)
  }
}

#Preview {
  ContentView()
}
