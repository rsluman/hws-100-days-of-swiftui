//
//  ContentView.swift
//  WeSplit
//
//  Created by Roelf Sluman on 15/07/2024.
//

import SwiftUI


struct ContentView: View {
  @State private var checkAmount = 0.0
  @State private var numberOfPeople = 2
  @State private var tipPercentage = 20
  
  @FocusState private var isAmountFocused: Bool
  
  let tipPercentages = [10, 15, 20, 25, 0]
  let currencyCode = Locale.current.currency?.identifier ?? "USD"
  
  var split: Double {
    checkAmount + (checkAmount / Double(numberOfPeople) * (Double(tipPercentage) / 100))
  }
  
  var body: some View {
    NavigationStack {
      Form {
        Section("What is the amount?") {
          TextField("Amount", value: $checkAmount, format: .currency(code: currencyCode))
            .keyboardType(.decimalPad)
            .focused($isAmountFocused)
            .foregroundColor(tipPercentage == 0 ? .red : .primary)
          
          Picker("Number of people", selection: $numberOfPeople) {
            ForEach(0..<100) {
              if $0 == 1 {
                Text("\($0) person")
              }
              else if $0 > 1 {
                Text("\($0) people")
              }
            }
          }
        }
        
        Section("How much do you want to tip?") {
          Picker("Tip Percentage", selection: $tipPercentage) {
            ForEach(tipPercentages, id: \.self) { percentage in
              Text("\(percentage)%")
            }
          }
          .pickerStyle(.segmented)
        }
        
        Section("Amount per person") {
          Text(split, format: .currency(code: currencyCode))
        }
      }
      .navigationTitle("WeSplit")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        if isAmountFocused {
          Button("Done") {
            isAmountFocused = false
          }
        }
      }
    }
  }
}

#Preview {
  ContentView()
}
