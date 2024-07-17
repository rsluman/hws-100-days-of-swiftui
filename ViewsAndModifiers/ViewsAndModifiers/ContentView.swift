//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Roelf Sluman on 17/07/2024.
//

import SwiftUI

struct ContentView: View {

  let t1 = Text("A simple constant")

  // let wrongT1 = Text("Hello (not").padding().background(.red)
  // ERROR: Property definition has inferred type 'some View', involving the 'some' return type of another declaration
  
  let t2: some View = Text("With one modifier").padding().background(.green)
  
  var t3: some View {
    Text("Computed property")
      .padding()
      .background(.red)
  }

  @ViewBuilder var t4: some View {
    Text("ViewBuilder")
      .padding()
      .background(.yellow)

  }
  
  
  var body: some View {
    VStack(spacing: 20) {
      t1
      t2
      t3
      t4
      Button("Show self's type") {
        print(type(of: self))
      }
    }
  }
}

#Preview {
  ContentView()
}
