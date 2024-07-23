//
//  ContentView.swift
//  Moonshot
//
//  Created by Roelf Sluman on 23/07/2024.
//

import SwiftUI

struct CustomText: View {
  var text: String
  
  var body: some View {
    Text(text)
  }
  
  init(_ text: String) {
    print("Creating a new CustomText for text \(text)")
    self.text = text
  }
}

struct ContentView: View {
  var body: some View {
    ScrollView() {
      LazyVStack(spacing: 10) {
        ForEach(0..<100) {
          CustomText("Item \($0)")
            .font(.title)
        }
      }
      // .frame(maxWidth: .infinity) not necessary with a LazyVStack
    }
  }
}

#Preview {
  ContentView()
}
