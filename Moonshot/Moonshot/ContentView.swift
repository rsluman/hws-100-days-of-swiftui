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
  
  @State private var shouldShowAsList = false
  
  struct modifiers: ViewModifier {
    @Binding var shouldShowAsList: Bool
    
    func body(content: Content) -> some View {
      return content
        .navigationTitle("Moonshot")
        .background(.darkBackground)
        .preferredColorScheme(.dark)
        .toolbar {
          Button {
            withAnimation {
              shouldShowAsList.toggle()
            }
          } label: {
            Label(
              shouldShowAsList ? "Grid" : "List",
              systemImage: shouldShowAsList ? "square.grid.2x2" : "list.dash")
          }
        }

    }
  }
  
  var body: some View {
    NavigationStack {
      if shouldShowAsList {
        CustomListView(astronauts: astronauts, missions: missions)
          .modifier(modifiers(shouldShowAsList: $shouldShowAsList))
      }
      else {
        CustomGridView(astronauts: astronauts, missions: missions)
          .modifier(modifiers(shouldShowAsList: $shouldShowAsList))
      }
    }
  }
}

struct CustomListView: View {
  let astronauts: [String: Astronaut]
  let missions: [Mission]
  
  var body: some View {
    
    List {
      ForEach(missions) { mission in
        NavigationLink {
          MissionView(mission, astronauts: astronauts)
        } label: {
          HStack(alignment: .top) {
            Image(mission.image)
              .resizable()
              .scaledToFit()
              .frame(width: 100, height: 60)
            VStack(alignment: .leading) {
              Text(mission.displayName)
                .font(.headline)
              Text(mission.formattedLaunchDate)
                .font(.caption)
            }
          }
          .padding(.vertical, 5)
        }
      }
      .listRowBackground(Color.darkBackground)
    }
    .listStyle(.plain)

  }
}

struct CustomGridView: View {
  let astronauts: [String: Astronaut]
  let missions: [Mission]

  let columns = [GridItem(.adaptive(minimum: 150))]
  
  var body: some View {
    ScrollView {
      LazyVGrid(columns: columns) {
        ForEach(missions) { mission in
          NavigationLink {
            MissionView(mission, astronauts: astronauts)
          } label: {
            VStack {
              Image(mission.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding()
              
              VStack {
                Text("\(mission.displayName)")
                  .font(.headline)
                  .foregroundStyle(.white)
                Text(mission.formattedLaunchDate)
                  .font(.caption)
                  .foregroundStyle(.gray)
              }
              .padding(.vertical)
              .frame(maxWidth: .infinity)
              .background(.lightBackground)
              
            }
            .clipShape(.rect(cornerRadius: 10))
            .overlay {
              RoundedRectangle(cornerRadius: 10)
                .stroke(.lightBackground)
            }
          }
        }
      }
      .padding([.horizontal, .bottom])
    }
    .navigationTitle("Moonshot")
    .background(.darkBackground)
    .preferredColorScheme(.dark)
  }
}


#Preview {
  ContentView()
}


