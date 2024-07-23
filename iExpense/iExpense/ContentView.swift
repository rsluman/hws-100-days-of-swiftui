//
//  ContentView.swift
//  iExpense
//
//  Created by Roelf Sluman on 22/07/2024.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
  static let types = ["Business", "Personal"]

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

  // Separate expenses into categories:
  var itemsByType: [String : [ExpenseItem]] {
    var result = [String : [ExpenseItem]]()

    for type in ExpenseItem.types {
      result[type] = items.filter() { $0.type == type }
    }
    
    return result
  }
  
  func removeItem(with id: UUID) {
    self.items.removeAll() { $0.id == id }
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
        ForEach(ExpenseItem.types, id: \.self) { type in

          Section(type) {
            ForEach(expenses.itemsByType[type] ?? [ExpenseItem]()) { item in
              ExpenseItemView(item: item)
            }
            .onDelete { indexSet in
              removeItem(type: type, atOffsets: indexSet)
            }
          }
        }
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
  
  func removeItem(type: String, atOffsets offsets: IndexSet) {
    if let first = offsets.first, let item = expenses.itemsByType[type]?[first] {
      expenses.removeItem(with: item.id)
    }
  }
}

struct ExpenseItemView: View {
  var item: ExpenseItem
  var amountFont: Font {
    if item.amount >= 100 {
      return .title
    }
    if item.amount >= 10 {
      return .title2
    }
    return .title3
  }
  
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
        .font(amountFont)
    }
  }
}


#Preview {
  ContentView()
}
