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
  
  @State private var errorTitle = ""
  @State private var errorMessage = ""
  @State private var shouldShowError = false
  
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
      .onAppear(perform: startGame)
      
      .alert(errorTitle, isPresented: $shouldShowError) { } message: {
        Text(errorMessage)
      }
    }
  }
  
  func startGame() {
    if let url = Bundle.main.url(forResource: "start", withExtension: "txt") {
      if let contents = try? String.init(contentsOf: url) {
        
        let allWords = contents.components(separatedBy: .newlines)
          .reduce([String]()) { $0 + [$1.trimmingCharacters(in: .whitespaces)] }
        
        if let randomWord = allWords.randomElement() {
          rootWord = randomWord
          return
        }
      }
    }
    fatalError("Could not find rootword in bundle")
  }
  
  func addNewWord() {
    var word = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines )
    
    guard !word.isEmpty else { return }
    
    if isOkToAdd(word: word) {
      shouldShowIncorrectEntry = false
      
      withAnimation {
        usedWords.insert(word, at: 0)
        newWord = ""
      }
    } else {
      shouldShowIncorrectEntry = true
    }
  }
  
  func isOkToAdd(word: String) -> Bool {
    guard isOriginal(word: word) else {
      wordError(title: "Word used already", message: "Be more original!")
      return false
    }
    
    guard isPossible(word: word) else {
      wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
      return false
    }
    
    guard isReal(word: word) else {
      wordError(title: "Word not recognized", message: "You can't just make them up!")
      return false
    }
    
    return true
  }
  
  func isOriginal(word: String) -> Bool {
    return !usedWords.contains(word)
  }
  
  func isPossible(word: String) -> Bool {
    var tempWord = rootWord
    
    for letter in word {
      if let index = tempWord.firstIndex(of: letter) {
        tempWord.remove(at: index)
      } else {
        return false
      }
    }
    return true
  }
  
  func isReal(word: String) -> Bool {
    let checker = UITextChecker()
    let range = NSRange(location: 0, length: word.utf16.count)
    
    let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
    
    return misspelledRange.location == NSNotFound
  }
  
  func wordError(title: String, message: String) {
    errorTitle = title
    errorMessage = message
    shouldShowError = true
  }
  
  
}

#Preview {
  ContentView()
}
