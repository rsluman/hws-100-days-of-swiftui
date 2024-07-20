//
//  ContentView.swift
//  BetterRest
//
//  Created by Roelf Sluman on 19/07/2024.
//

import SwiftUI

struct ContentView: View {
  @State private var wakeUp = Date.now
  @State private var sleepAmount = 8.0
  @State private var coffeeAmount = 1
  
  var body: some View {
    NavigationStack {
      List {
        Section("When do you want to wake up?") {
          DatePicker("Enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
            .labelsHidden()
        }
        
        
        Section("Desired amount of sleep") {
          Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
            Text("\(sleepAmount.formatted()) hours")
          }
        }

        Section("Daily Coffee Intake") {
          Stepper(value: $coffeeAmount, in: 0...20) {
            Text("\(coffeeAmount.formatted()) cup\(coffeeAmount != 1 ? "s" : "")")
          }
        }


      }
      .navigationTitle("BetterRest")
      .toolbar {
        Button("Calculate", action: calculateBedTime)
      }
    }
  }
  
  func calculateBedTime() {
    
  }
}

#Preview {
  ContentView()
}
