//
//  ContentView.swift
//  iExpense
//
//  Created by Roelf Sluman on 22/07/2024.
//

import SwiftUI

struct ExpenseItem {
  let name: String
  let type: String
  let amount: Double
}

@Observable
class Expenses {
  var items = [ExpenseItem]()
}

struct ContentView: View {
  @State var expenses = Expenses()
  
  var body: some View {
    NavigationStack {
        List {
          ForEach(expenses.items, id: \.name) { item in
            Text(item.name)
          }
          .onDelete(perform: removeItems)
      }
      .navigationTitle("iExpense")
      .toolbar {
        Button("Add Expense", systemImage: "plus") {
          let item = ExpenseItem(name: "Test", type: "Personal", amount: 5)
          expenses.items.append(item)
        }
      }
    }
  }
  
  func removeItems(atOffsets offsets: IndexSet) {
    expenses.items.remove(atOffsets: offsets)
  }
}

/*
struct AddItemView: View {
  @Environment(\.dismiss) private var dismiss
  
  @State var expenses: Expenses
  
  @State var itemName = ""
  @State var itemType = ""
  @State var itemAmount = ""

  var body: some View {
    Form {
      TextField("Name", text: $itemName)
      TextField("Type", text: $itemType)
      TextField("Amount", text: $itemAmount)
        .keyboardType(.decimalPad)
    }
    .toolbar {
      Button("Save") {
        if let itemAmount = Double(itemAmount), !itemName.isEmpty && !itemType.isEmpty && !itemAmount.isZero  {
          expenses.items.append(ExpenseItem(name: itemName, type: itemType, amount: itemAmount))
        }
        dismiss()
        return
        
      }
    }
  }
}
 
 */

#Preview {
  ContentView()
}
