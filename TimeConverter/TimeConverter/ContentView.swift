//
//  ContentView.swift
//  TimeConverter
//
//  Created by Roelf Sluman on 15/07/2024.
//

import SwiftUI

struct ContentView: View {
  var timeOptions = ["Seconds", "Minutes", "Hours", "Days"]
  @State private var time = Double(60)
  @State private var fromTimeSelected = "Seconds"
  @State private var toTimeSelected = "Minutes"
  
  var amountInSeconds: Double {
    // Amount naar seconden omrekenen:
    switch fromTimeSelected {
    case "Minutes":
      return time * 60
    case "Hours":
      return time * 3600
    case "Days":
      return time * 3600 * 24
    default: // seconds
      return time
    }
  }
  
  var convertedTime: Double {
    switch toTimeSelected {
    case "Minutes":
      return amountInSeconds / 60
    case "Hours":
    return amountInSeconds / 3600
    case "Days":
      return amountInSeconds / 3600 / 24
    default: // seconds
      return amountInSeconds
    }
  }
  
  
  @FocusState private var isTimeFocused: Bool
  
  let formatter = NumberFormatter()
  
  var body: some View {
    NavigationStack {
      Form {
        Section("Time:") {
          TextField("Time", value: $time, formatter: formatter)
          //          TextField("Amount", text: $amount)
            .keyboardType(.decimalPad)
            .focused($isTimeFocused)
        }
        
        Section("From:") {
          Picker("From", selection: $fromTimeSelected) {
            ForEach(timeOptions, id: \.self) { option in
              Text(option)
                .selectionDisabled(option == toTimeSelected)
            }
          }
          .pickerStyle(.segmented)
          
        }
        Section("To:") {
          Picker("To", selection: $toTimeSelected) {
            ForEach(timeOptions, id: \.self) { option in
              Text(option)
                .selectionDisabled(option == fromTimeSelected)
            }
          }
          .pickerStyle(.segmented)
          
          
        }
        Section("And here are the results!") {
          Text("\(convertedTime)")
          
        }
        
      }
      .navigationTitle("Time Converter")
      .navigationBarTitleDisplayMode(.inline)
      
      .toolbar {
        if isTimeFocused {
          Button("Done") {
            isTimeFocused = false
          }
        }
      }
    }
  }
}

#Preview {
  ContentView()
}
