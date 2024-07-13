//
//  WordValidation.swift
//  WordScramble
//
//  Created by Jake Go on 7/12/24.
//

import Foundation
import SwiftUI

struct WordValidation {
    let usedWords: [String] = []
    let rootWord: String
    
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
}

