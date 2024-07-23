//
//  ContentView.swift
//  iExpense
//
//  Created by Roelf Sluman on 22/07/2024.
//

import SwiftUI

struct User: Codable {
  let firstName: String
  let lastName: String
}

struct ContentView: View {
  @State private var user = User(firstName: "Taylor", lastName: "Swift")
  
  var body: some View {
    Button("Save User") {
      let encoder = JSONEncoder()
      
      if let data = try? encoder.encode(user) {
        UserDefaults.standard.setValue(data, forKey: "UserData")
      }
    }
  }
}

#Preview {
  ContentView()
}
