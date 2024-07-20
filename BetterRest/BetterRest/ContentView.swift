//
//  ContentView.swift
//  BetterRest
//
//  Created by Roelf Sluman on 19/07/2024.
//

import CoreML
import SwiftUI

struct ContentView: View {
  @State private var wakeUp = defaultWakeTime
  @State private var sleepAmount = 8.0
  @State private var coffeeAmount = 1
  
  @State private var alertTitle = ""
  @State private var alertMessage  = ""
  @State private var isShowingAlert = false
  
  static private var defaultWakeTime: Date {
    var components = DateComponents()
    components.hour = 7
    components.minute = 0
    return Calendar.current.date(from: components) ?? .now
  }
  
  
  var body: some View {
    NavigationStack {
      Form {
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
            Text("^[\(coffeeAmount) cup](inflect: true)")
          }
        }
      }
      .padding()
      
      .alert(alertTitle, isPresented: $isShowingAlert) {
        Button("OK") { }
      } message: {
        Text(alertMessage)
      }
      
      .navigationTitle("BetterRest")
      .toolbar {
        Button("Calculate", action: calculateBedTime)
      }
    }
  }
  
  func calculateBedTime() {
    let c = Calendar.current
    
    do {
      let config = MLModelConfiguration()
      let model = try SleepCalculator(configuration: config)
      
      let components = c.dateComponents([.hour, .minute], from: wakeUp)
      let hour = components.hour ?? 0 * 60 * 60
      let minute = components.minute ?? 0 * 60
      
      let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
      
      let sleepTime = wakeUp - prediction.actualSleep
      
      alertTitle = "Your ideal bedtime is …"
      alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
    } catch {
      // something went wrong
      alertTitle = "Error"
      alertMessage = "Sorry, there was a problem calculating your bedtime."
    }
    
    isShowingAlert = true
    
  }
}

#Preview {
  ContentView()
}
