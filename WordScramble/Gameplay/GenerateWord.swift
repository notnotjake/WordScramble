//
//  GenerateWord.swift
//  WordScramble
//
//  Created by Jake Go on 7/12/24.
//

import Foundation

func generateWord () -> String {
    // Find our text inside the bundle
    if let textFileURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
        if let startWords = try? String(contentsOf: textFileURL) {
            let allWords = startWords.components(separatedBy: "\n")
//            let newWord = allWords.randomElement() ?? "silkworm"
//            print(newWord)
//            return newWord
            return allWords.randomElement() ?? "silkworm"
        }
    }
    else {
        fatalError("Could not load start.txt from app bundle")
    }
    return "silkworm"
}
