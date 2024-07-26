//
//  MissionView.swift
//  Moonshot
//
//  Created by Roelf Sluman on 26/07/2024.
//

import SwiftUI

struct MissionView: View {
  struct CrewMember {
    let role: String
    let astronaut: Astronaut
  }
  
  var mission: Mission
  var astronauts: [String : Astronaut]
  var crewMembers: [CrewMember] {
    var members = [CrewMember]()
    for member in mission.crew {
      guard let astronaut = astronauts[member.name] else {
        fatalError("MissionView: no astronaut data for \(member.name)")
      }

      members.append(CrewMember(role: member.role, astronaut: astronaut))
    }
    return members
  }
  
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
        
        Text(crewMembers[0].role)
        
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
