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
      VStack {
        List {
          ForEach(numbers, id: \.self) {
            Text("\($0)")
          }
          // .onDelete { removeRows(atOffsets: $0) }
          .onDelete(perform: removeRows)
        }
        
        Button("Add Number") {
          numbers.append(currentNumber)
          currentNumber += 1
        }
      }
      .toolbar {
        EditButton()
      }
    }
    
  }
  
  func removeRows(atOffsets offsets: IndexSet) {
    numbers.remove(atOffsets: offsets)
  }
}


#Preview {
  ContentView()
}
