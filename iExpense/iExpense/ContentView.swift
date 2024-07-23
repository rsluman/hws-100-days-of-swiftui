//
//  ContentView.swift
//  iExpense
//
//  Created by Roelf Sluman on 22/07/2024.
//

import SwiftUI

struct ContentView: View {
  @State private var numbers = [Int]()
  @State private var currentNumber = 1
  
  var body: some View {
    NavigationStack {
      List {
        ForEach(numbers, id: \.self) {
          Text("\($0)")
        }
        .onDelete { deleteNumber($0) }
      }
      .toolbar {
        Button("Add") {
          numbers.append(currentNumber)
          currentNumber += 1
        }
      }
    }
    
  }
  
  func deleteNumber(_ indexSet: IndexSet) {
    if let i = indexSet.first {
      numbers.remove(at: i)
    }
  }
}



#Preview {
  ContentView()
}
