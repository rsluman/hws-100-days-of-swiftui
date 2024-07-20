//
//  ContentView.swift
//  BetterRest
//
//  Created by Roelf Sluman on 19/07/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
      
        .onAppear() {
          exampleDates()
        }
    }
  
  func exampleDates() {
    var components = DateComponents()
    components.hour = 8
    components.minute = 0
    let date = Calendar.current.date(from: components) ?? .now
    print(date.formatted())
    print(Date.now.formatted(date: .numeric, time: .omitted))
    
  }
}

#Preview {
    ContentView()
}
