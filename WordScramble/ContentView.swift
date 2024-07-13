//
//  ContentView1.swift
//  WordScramble
//
//  Created by Jake Go on 7/2/24.
//

import SwiftUI

public enum GameViews {
    case menu, howToPlay, frantic, timed, zen
}

struct ContentView: View {
    @State public var showingView: GameViews = .menu
    
    var body: some View {
        switch showingView {
        case .menu:
            GameMenu(showingView: $showingView)
        case .howToPlay:
            GameMenu(showingView: $showingView)
        case .frantic:
            GameplayFrantic(showingView: $showingView)
        case .timed:
            GameplayFrantic(showingView: $showingView)
        case .zen:
            GameplayFrantic(showingView: $showingView)
        }
    }
}

#Preview {
    ContentView()
}
