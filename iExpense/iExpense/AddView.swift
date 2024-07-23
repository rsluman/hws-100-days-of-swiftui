//
//  AddView.swift
//  iExpense
//
//  Created by Roelf Sluman on 23/07/2024.
//

import SwiftUI

struct AddView: View {
  @State private var name = ""
  @State private var type = "Personal"
  @State private var amount = 0.0
  
  var expenses: Expenses
  
  let types = ["Business", "Personal"]
  
  var body: some View {
    NavigationStack {
      Form {
        TextField("Name", text: $name)

        Picker("Type", selection: $type) {
          ForEach(types, id: \.self) {
            Text($0)
          }
        }
        
        TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
          .keyboardType(.decimalPad)
        
      }
      .navigationTitle("Add New Expense")
    }
  }
}

#Preview {
  AddView(expenses: Expenses())
}
