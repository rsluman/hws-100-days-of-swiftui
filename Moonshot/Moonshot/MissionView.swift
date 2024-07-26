//
//  MissionView.swift
//  Moonshot
//
//  Created by Roelf Sluman on 26/07/2024.
//

import SwiftUI

struct MissionView: View {
  var mission: Mission
  var astronauts: [String : Astronaut]
  
  init(_ mission: Mission, astronauts: [String : Astronaut]) {
    self.mission = mission
    self.astronauts = astronauts
  }

  var body: some View {
    ScrollView {
      VStack {
        Image(mission.image)
          .resizable()
          .scaledToFit()
          .containerRelativeFrame(.horizontal) { width, axis in
            return width * 0.6
          }
        
        VStack(alignment: .leading) {
          Text("Mission Highlights")
            .font(.title.bold())
            .padding(.bottom, 5)
          
          Text(mission.description)
            
        }
        .padding()
      }
    }
    .navigationTitle(mission.displayName)
    .navigationBarTitleDisplayMode(.inline)
    .background(.darkBackground)
  }
}

#Preview {
  let missions: [Mission] = Bundle.main.decode("missions.json")
  let astronauts: [String : Astronaut] = Bundle.main.decode("astronauts.json")

  return MissionView(missions.first!, astronauts: astronauts)
    .preferredColorScheme(.dark)
}
