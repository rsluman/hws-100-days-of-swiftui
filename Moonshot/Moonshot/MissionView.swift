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
  var crew: [CrewMember]
  
  init(_ mission: Mission, astronauts: [String : Astronaut]) {
    self.mission = mission
    self.astronauts = astronauts
    self.crew = mission.crew.map() { member in
      guard let astronaut = astronauts[member.name] else {
        fatalError("MissionView critical error: astronaut \(member.name) not found")
      }
      return CrewMember(role: member.role, astronaut: astronaut)
    }
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
        
        if let date = mission.launchDate {
          Text(date.formatted(date: .complete, time: .omitted))
            .font(.headline)
            .padding(.top, 5)
        }
        
        VStack(alignment: .leading) {
          CustomDivider()
          
          Text("Mission Highlights")
            .font(.title.bold())
            .padding(.bottom, 5)
          
          Text(mission.description)
          
          CustomDivider()
          
          Text("Crew")
            .font(.title.bold())
            .padding(.bottom, 5)
          
        }
        .padding()
        
        CrewView(crew: crew, astronauts: astronauts)
        
      }
    }
    .navigationTitle(mission.displayName)
    .navigationBarTitleDisplayMode(.inline)
    .background(.darkBackground)
  }
}

struct CustomDivider: View {
  var body: some View {
    Rectangle()
      .frame(height: 2)
      .foregroundStyle(.lightBackground)
      .padding(.vertical)
  }
}

struct CrewView: View {
  var crew: [MissionView.CrewMember]
  var astronauts: [String: Astronaut]

  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack {
        ForEach(crew, id: \.self.astronaut.id) { crewMember in
          NavigationLink {
            AstronautView(crewMember.astronaut)
          } label: {
            HStack {
              Image(crewMember.astronaut.id)
                .resizable()
                .scaledToFit()
                .frame(width: 104, height: 72)
                .clipShape(.capsule)
                .overlay {
                  Capsule()
                    .strokeBorder(.white, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                }
              
              VStack(alignment: .leading) {
                Text(crewMember.astronaut.name)
                  .foregroundStyle(.white)
                  .font(.headline)
                Text(crewMember.role)
                  .foregroundStyle(.white.opacity(0.5))
              }
            }
            .padding(.horizontal)
          }
        }
        
      }
    }
  }
}


#Preview {
  let missions: [Mission] = Bundle.main.decode("missions.json")
  let astronauts: [String : Astronaut] = Bundle.main.decode("astronauts.json")
  
  return MissionView(missions[1], astronauts: astronauts)
    .preferredColorScheme(.dark)
  
}



