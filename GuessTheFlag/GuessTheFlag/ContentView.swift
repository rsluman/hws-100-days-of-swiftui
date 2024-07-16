//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Roelf Sluman on 15/07/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//      LinearGradient(colors: [.white, .black], startPoint: .top, endPoint: .bottom)

//      LinearGradient(stops: [
//        .init(color: .white, location: 0.45),
//        .init(color: .black, location: 0.55)
//      ], startPoint: .top, endPoint: .bottom)

      // vanaf het midden: blauwe cirkel met een straal van 20 punten
      // dan een gradient cirkel van blauw naar zwart met een straal van 200 punten
//      RadialGradient(colors: [.blue, .black],
//                     center: .center, startRadius: 20, endRadius: 200)
      
//      AngularGradient(colors: [.red, .yellow, .green, .blue, .purple, .red], center: .center)
      
      // Standaard gradient, als modifier:
        Text("Your content")
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.indigo.gradient)
        
        
      
    }
}

#Preview {
    ContentView()
}
