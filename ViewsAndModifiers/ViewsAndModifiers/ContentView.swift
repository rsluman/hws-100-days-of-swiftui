//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Roelf Sluman on 17/07/2024.
//

import SwiftUI

extension View {
  var titleStyle: some View {
    self.modifier(Title())
  }
}

struct Title: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.largeTitle)
      .foregroundStyle(.white)
      .padding()
      .background(.blue)
      .clipShape(RoundedRectangle(cornerRadius: 15))
  }
}

extension View {
  func watermarked(with text: String) -> some View {
    self.modifier(Watermark(text: text))
  }
  
}


struct Watermark: ViewModifier {
  var text: String
  
  func body(content: Content) -> some View {
    ZStack(alignment: .bottomTrailing) {
      content
      
      Text(text)
        .font(.caption)
        .foregroundStyle(.white)
        .padding(5)
        .background(.black)
    }
    
  }
}


struct ContentView: View {
  
  var body: some View {
    Text("Hello world!")
      .frame(width: 200, height: 200)
      .background(.blue)
      .watermarked(with: "Hacking with Swift")
  }
}

#Preview {
  ContentView()
}
