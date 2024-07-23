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
          .onDelete() { expenses.items.remove(atOffsets: $0) }
      }
      .navigationTitle("iExpense")
      .toolbar {
        NavigationLink("Add Item", destination: AddItemView(expenses: expenses))
      }
    }
  }
}

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

#Preview {
  ContentView()
}
