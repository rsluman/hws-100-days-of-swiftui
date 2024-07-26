//
//  ContentView.swift
//  Moonshot
//
//  Created by Roelf Sluman on 23/07/2024.
//

import SwiftUI

struct ContentView: View {
  let astronauts: [String : Astronaut] = Bundle.main.decode("astronauts.json")
  
  var body: some View {
    Text("\(astronauts.count)")
  }
}



#Preview {
  ContentView()
}
