//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Roelf Sluman on 17/07/2024.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack(spacing: 10) {
      CapsuleText(title: "First")
      CapsuleText(title: "Second")
    }
  }
 
}

#Preview {
  ContentView()
}

struct CapsuleText: View {
  var title: String
  var body: some View {
    Text(title)
      .font(.largeTitle)
      .padding()
      .foregroundStyle(.white)
      .background(.blue)
      .clipShape(.capsule)
  }
}
