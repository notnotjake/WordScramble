//
//  ContentView1.swift
//  WordScramble
//
//  Created by Jake Go on 7/2/24.
//

import SwiftUI

/*
 In the frantic gamemode, you start with 30 seconds. Every time you get a word, you get an additional 10 seconds. Once you get 16 points, you get a new word
 */

struct GameplayFrantic: View {
    @Binding var showingView: GameViews
    
    @State private var usedWords: [String] = []
    @State private var rootWord: String = ""
    @State private var newWord: String = ""
    
    @FocusState private var focusedField: FocusedField?
    
    var score: Int {
        var s = 0
        for word in usedWords {
            s += word.count
        }
        return s
    }
        
    @State private var errorMessage: String = ""
    @State private var errorShowing: Bool = false
    
    
    var body: some View {
        VStack {
            VStack {
                VStack {
                    ToolbarView(showingView: $showingView, focusedField: _focusedField)
                    Group {
                        if errorShowing {
                            Text(errorMessage)
                                .foregroundStyle(.red)
                        } else {
                            Text("Make Words With")
                                .font(.system(.headline, design: .rounded).weight(.medium))
                                .foregroundStyle(.primary.opacity(0.7))
                        }
                    }
                    .padding(.bottom, -10)
                    TestNewWordInteraction(rootWord: $rootWord)
                }
                .padding(.top, 5)
                
                VStack {
                    TextField("Enter Your Word", text: $newWord)
                        .submitLabel(.go)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .onSubmit(addNewWord)
                        .onChange(of: newWord, dismissError)
                        .focused($focusedField, equals: .newWordField)
                        .padding()
                        .background(.primary.opacity(0.07))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
            }
            .padding(.bottom, 20)
            VStack(alignment: .center) {
                ProgressBar(progress: 0.5, highlightColor: .green)
                
                if usedWords.isEmpty {
                    Spacer()
                    Text("You got this!")
                        .font(.system(.title3, design: .rounded).weight(.medium))
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity)
                    Spacer()
                    Spacer()
                }
                else {
                    VStack(spacing: 8) {
                        Text("50 Seconds")
                            .font(.system(.headline, design: .rounded).weight(.regular))
                            .foregroundStyle(.primary).opacity(0.5)
                        
                        Text("^[\(score) POINTS](inflect: true)")
                            .font(.system(.headline, design: .rounded).weight(.medium))
                    }
                    
                    List {
                        ForEach(usedWords, id: \.self) { word in
                            HStack {
                                Image(systemName: "\(word.count).circle.fill")
                                Text(word.uppercased())
                            }
                        }
                    }
                    .padding(.top, 0)
                    .listStyle(.insetGrouped)
                    .background(.background.secondary)
                }
            }
            .frame(maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .background(.background.secondary)
        }
        .onAppear(perform: startGame)
    }
    
    func startGame () {
//        rootWord = generateWord()
//        now handled by the word text
    }
    
    func newWordIsOriginal (word: String) -> Bool {
        !usedWords.contains(word)
    }
    func newWordIsDesendant (word: String) -> Bool {
        var rootWordCopy = rootWord
        for letter in word {
            if let pos = rootWordCopy.firstIndex(of: letter) {
                rootWordCopy.remove(at: pos)
            }
            else {
                return false
            }
        }
        return true
    }
    func newWordIsRealWord (word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: true, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    func newWordIsNotRoot (word: String) -> Bool {
        word != rootWord
    }
    func newWordIsLongEnough (word: String, length: Int) -> Bool {
        word.count > length
    }
    
    
    func newWordError (message: String) {
        errorMessage = message
        errorShowing = true
    }
    func dismissError () {
        errorMessage = ""
        errorShowing = false
    }
    
    
    func addNewWord () {
        focusedField = .newWordField
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else { return }
        
        guard newWordIsOriginal(word: answer) else {
            newWordError(message: "Word Used Already")
            return
        }
        
        guard newWordIsDesendant(word: answer) else {
            newWordError(message: "Word Can't Be Made From \(rootWord.capitalized)")
            return
        }
        
        guard newWordIsRealWord(word: answer) else {
            newWordError(message: "Word Not in Word List")
            return
        }
        
        guard newWordIsNotRoot(word: answer) else {
            newWordError(message: "Word Not Original")
            return
        }
        
        guard newWordIsLongEnough(word: answer, length: 3) else {
            newWordError(message: "Word Too Short")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
    }
    
}

#Preview {
    GameplayFrantic(showingView: .constant(.frantic))
}
