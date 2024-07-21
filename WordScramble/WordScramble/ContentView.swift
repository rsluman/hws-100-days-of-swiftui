//
//  ContentView.swift
//  WordScramble
//
//  Created by Roelf Sluman on 21/07/2024.
//

import SwiftUI

struct ContentView: View {
  let minimumWordLength = 3
  
  @State private var usedWords = [String]()
  @State private var rootWord = ""
  @State private var newWord = ""
  
  @State private var errorTitle = ""
  @State private var errorMessage = ""
  @State private var shouldShowError = false
  
  @State private var score = 0
  
  var body: some View {
    NavigationStack {
      List {
        Section {
          TextField("Enter your word", text: $newWord)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled(true)
            .onSubmit(addNewWord)
          
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
      .toolbar {
        Button("New Game", action: startGame)
      }
      
      .navigationTitle(rootWord)
      .onAppear(perform: startGame)
      
      .alert(errorTitle, isPresented: $shouldShowError) { } message: {
        Text(errorMessage)
      }
      
      Spacer()
      
      Text("Your score: \(score)")
        .font(.largeTitle)
        .fontWeight(.semibold)
        .foregroundStyle(.secondary)
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
      withAnimation {
        usedWords.insert(word, at: 0)
        calculateScore()
        newWord = ""
      }
    }
  }
  
  func isOkToAdd(word: String) -> Bool {
    guard isLongEnough(word: word) else {
      wordError(title: "Word is too short", message: "Use at least \(minimumWordLength) characters")
      return false
    }
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
    return word != rootWord && !usedWords.contains(word)
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
  
  func isLongEnough(word: String) -> Bool {
    return word.count >= minimumWordLength
  }
  
  func wordError(title: String, message: String) {
    errorTitle = title
    errorMessage = message
    shouldShowError = true
  }
  
  func calculateScore() {
    var score = 0
    for word in usedWords {
      score += word.count
    }
    self.score = score
  }
  
  
}

#Preview {
  ContentView()
}
