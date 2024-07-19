//
//  ContentView.swift
//  BetterRest
//
//  Created by Roelf Sluman on 19/07/2024.
//

import SwiftUI

struct ContentView: View {
  @State private var wakeUp = Date.now
  
  var body: some View {
    DatePicker("Please enter a date", selection: $wakeUp, in: ...Date.now)
      .labelsHidden()
  }
  
  func exampleDates() {
    let tomorrow = Date.now.addingTimeInterval(24 * 60 * 60)
    let range = Date.now...tomorrow
    let fromNowRange = Date.now...
    let tillNowRange = ...Date.now
    let beforeNowrange = ..<Date.now
  }
}

#Preview {
  ContentView()
}
