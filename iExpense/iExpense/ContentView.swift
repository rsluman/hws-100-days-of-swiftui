//
//  ContentView.swift
//  iExpense
//
//  Created by Roelf Sluman on 22/07/2024.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
  var id = UUID()
  let name: String
  let type: String
  let amount: Double
}

@Observable
class Expenses {
  var items = [ExpenseItem]() {
    didSet {
      // save to userDefaults
      if let encoded = try? JSONEncoder().encode(items) {
        UserDefaults.standard.setValue(encoded, forKey: "Items")
      }
    }
  }
  
  init() {
    if let data = UserDefaults.standard.data(forKey: "Items") {
      if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: data) {
        items = decodedItems
      }
    }
  }
    
}

struct ContentView: View {
  @State var expenses = Expenses()
  
  @State private var showingAddExpense = false
  
  var body: some View {
    NavigationStack {
      List {
        ForEach(expenses.items) { item in
          ExpenseItemView(item: item)
        }
        .onDelete(perform: removeItems)
      }
      .navigationTitle("iExpense")
      .toolbar {
        
        Button("Add Expense", systemImage: "plus") {
          showingAddExpense = true
        }
        
      }
      .sheet(isPresented: $showingAddExpense) {
        AddView(expenses: expenses)
      }
      
    }
  }
  
  func removeItems(atOffsets offsets: IndexSet) {
    expenses.items.remove(atOffsets: offsets)
  }
}

struct ExpenseItemView: View {
  var item: ExpenseItem
  
  var body: some View {
    HStack(alignment: .top) {
      VStack(alignment: .leading) {
        Text(item.name)
          .font(.headline)
        Text(item.type)
          .font(.caption)
      }
      Spacer()
      Text(item.amount.formatted(.currency(code: Locale.current.currency?.identifier ?? "USD")))
    }
  }
}


#Preview {
  ContentView()
//  ExpenseItemView(item: ExpenseItem(name: "Lunch", type: "Work", amount: 15.23))
}
