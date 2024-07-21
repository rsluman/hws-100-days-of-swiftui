//
//  ContentView.swift
//  WordScramble
//
//  Created by Roelf Sluman on 21/07/2024.
//

import SwiftUI

struct ContentView: View {
  @State private var usedWords = [String]()
  @State private var rootWord = ""
  @State private var newWord = ""
  
  @State private var shouldShowIncorrectEntry = false
  
  var body: some View {
    NavigationStack {
      List {
        Section {
          TextField("Enter your word", text: $newWord)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled(true)
            .foregroundStyle(shouldShowIncorrectEntry ? .red : .primary)
            .onSubmit(addNewWord)
          
            .onChange(of: newWord) {
              if newWord.isEmpty {
                shouldShowIncorrectEntry = false
              }
            }
        }
        
        Section {
          ForEach(usedWords, id: \.self) { word in
            HStack {
              Image(systemName: "\(word.count).circle")
                .foregroundStyle(.secondary)
              Text(word)
            }
          }
        }
      }
      .navigationTitle(rootWord)
    }
  }
  
  func addNewWord() {
    var word = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines )
    
    guard !word.isEmpty else { return }
    
    if isSpelledCorrectly(word: word) {
      if !usedWords.contains(word) {
        shouldShowIncorrectEntry = false
        
        withAnimation {
          usedWords.insert(word, at: 0)
          newWord = ""
        }
      }
    } else {
      shouldShowIncorrectEntry = true
    }
  }
  
  func isSpelledCorrectly(word: String) -> Bool {
    let checker = UITextChecker()
    let range = NSRange(location: 0, length: word.utf16.count)
    
    let checkedRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
    
    return checkedRange.location == NSNotFound
  }
  
}

#Preview {
  ContentView()
}
