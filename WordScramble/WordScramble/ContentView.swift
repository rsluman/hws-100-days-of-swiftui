//
//  ContentView.swift
//  WordScramble
//
//  Created by Roelf Sluman on 21/07/2024.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundStyle(.tint)
      Text("Hello, world!")
    }
    .padding()
    .onAppear {
      testStrings()
    }
  }
  
  func testStrings() {
//    let input = """
//                a
//                b
//                c
//                """
//    
//    let trimmedString = input.trimmingCharacters(in: .whitespaces)
//    let stringArray = trimmedString.components(separatedBy: "\n")
//    let randomString = stringArray.randomElement()
//    print(randomString!)
    
    let word = "swift"
    let checker = UITextChecker()
    let range = NSRange(location: 0, length: word.utf16.count)
    let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
    
    let allGood = misspelledRange.location == NSIntegerMax
    print(allGood)
    print(misspelledRange.location)
    print(NSNotFound == misspelledRange.location)
  }
}

#Preview {
  ContentView()
}
