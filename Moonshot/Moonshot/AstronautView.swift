//
//  AstronautView.swift
//  Moonshot
//
//  Created by Roelf Sluman on 26/07/2024.
//

import SwiftUI

struct AstronautView: View {
  var astronaut: Astronaut
  
  init(_ astronaut: Astronaut) {
    self.astronaut = astronaut
  }

  var body: some View {
    ScrollView {
      VStack(alignment: .leading) {
        Image(astronaut.id)
          .resizable()
          .scaledToFit()
          .padding(.bottom, 20)
        
        Text(astronaut.name)
          .font(.title.bold())
          .padding(.bottom, 10)
        
        Text(astronaut.description)
      }
      .padding()
    }
    .navigationTitle(astronaut.name)
    .navigationBarTitleDisplayMode(.inline)
    .background(.darkBackground)
  }
}

#Preview {
  let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
  return AstronautView(astronauts["armstrong"]!)
    .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
