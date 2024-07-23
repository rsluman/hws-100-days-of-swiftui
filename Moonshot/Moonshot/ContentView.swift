//
//  ContentView.swift
//  Moonshot
//
//  Created by Roelf Sluman on 23/07/2024.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    Image(.example)
      .resizable()
      .scaledToFit()
      .containerRelativeFrame(.horizontal) { size, axis in
        size * 0.8
      }
  }
}

#Preview {
  ContentView()
}
