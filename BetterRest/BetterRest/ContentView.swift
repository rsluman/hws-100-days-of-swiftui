//
//  ContentView.swift
//  BetterRest
//
//  Created by Roelf Sluman on 19/07/2024.
//

import SwiftUI

struct ContentView: View {
  @State var sleepAmount = 8.0
  
  var body: some View {
    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
  }
}

#Preview {
  ContentView()
}
