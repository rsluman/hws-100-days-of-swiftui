//
//  ContentView.swift
//  iExpense
//
//  Created by Roelf Sluman on 22/07/2024.
//

import SwiftUI

@Observable
class User {
  var firstName = "Bilbo"
  var lastName = "Baggins"
}

struct ContentView: View {
  @State private var user = User()
  
  var body: some View {
    VStack {
      Text("Your name is \(user.firstName) \(user.lastName)")
      TextField("First name", text: $user.firstName)
      TextField("Last name", text: $user.lastName)
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
