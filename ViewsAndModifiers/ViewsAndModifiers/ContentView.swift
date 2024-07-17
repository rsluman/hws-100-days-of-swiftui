//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Roelf Sluman on 17/07/2024.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack(alignment: .leading) {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundStyle(.tint)
      Text("Hello, world!")
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.red)
  }
}

#Preview {
  ContentView()
}
