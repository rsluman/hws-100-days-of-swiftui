//
//  ContentView.swift
//  Moonshot
//
//  Created by Roelf Sluman on 23/07/2024.
//

import SwiftUI

struct User: Codable {
  let name: String
  let address: Address
}

struct Address: Codable {
  let street: String
  let city: String
}


struct ContentView: View {
  var body: some View {
    Button("Decode JSON") {
      let input = """
                  {
                    "name": "Taylor Swift",
                    "address": {
                      "street": "555 Taylor Swift Avenue",
                      "city": "Nashville"
                    }
                  }
                  """
      
      let data = Data(input.utf8)
      let decoder = JSONDecoder()
      
      if let user = try? decoder.decode(User.self, from: data) {
        print(user.address.street)
      }
    }
    
  }
}

#Preview {
  ContentView()
}
