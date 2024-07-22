//
//  ContentView.swift
//  iExpense
//
//  Created by Roelf Sluman on 22/07/2024.
//

import SwiftUI

struct SecondView: View {
  @Environment(\.dismiss) private var dismiss
  
  var name: String

  var body: some View {
    VStack {
      Button("Dismiss") {
        dismiss()
      }
    }
    
  }
}

struct ContentView: View {
  @State private var isShowingSheet = false
  
  var body: some View {
    Button("Show Sheet") {
      isShowingSheet.toggle()
    }
    .sheet(isPresented: $isShowingSheet) {
      SecondView(name: "Roelf")
    }
      
  }
}


#Preview {
  ContentView()
}
