//
//  ContentView.swift
//  Moonshot
//
//  Created by Roelf Sluman on 23/07/2024.
//

import SwiftUI

struct ContentView: View {
  let astronauts: [String : Astronaut] = Bundle.main.decode("astronauts.json")
  let missions: [Mission] = Bundle.main.decode("missions.json")
  
  var body: some View {
    VStack {
      Text("\(astronauts.count)")
      Text("\(missions.count)")
    }
  }
}



#Preview {
  ContentView()
}
