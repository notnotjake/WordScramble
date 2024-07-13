//
//  GameMenu.swift
//  WordScramble
//
//  Created by Jake Go on 7/8/24.
//

import SwiftUI

enum Gamemodes {
    case frantic, timed, zen
}
struct CompletedGames: Hashable {
    let word: String
    let score: Int
    let date: Date
    let gamemode: Gamemodes
    
    var gamemodeString: String {
        switch gamemode {
        case .frantic:
            return "Frantic"
        case .timed:
            return "Timed"
        case .zen:
            return "Zen"
        }
    }
    var gamemodeIcon: String {
        switch gamemode {
        case .frantic:
            return "bolt.circle.fill"
        case .timed:
            return "stopwatch.fill"
        case .zen:
            return "circle.circle.fill"
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(word)
        hasher.combine(score)
        hasher.combine(date)
        hasher.combine(gamemodeString)
    }
}

struct GameMenu: View {
    @Binding var showingView: GameViews
    @State private var showingHelp = false
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationStack {
                HistoryView()
            }
            
            VStack {
                VStack {
                    Divider()
                    Text("Start New Game")
                        .font(.system(.title, design: .rounded).weight(.bold))
                        .padding(.vertical, 24)
                    
                    VStack(spacing: 10) {
                        GameModeButton(showingView: $showingView, name: "Frantic", systemImage: "bolt.circle.fill", highScore: 36, target: .frantic)
                        GameModeButton(showingView: $showingView, name: "Timed", systemImage: "stopwatch.fill", highScore: 36, target: .timed)
                        GameModeButton(showingView: $showingView, name: "Zen", systemImage: "circle.circle.fill", highScore: 36, target: .zen)
                    }
                        .padding(.horizontal, 40)
                    
                    Button {
                        showingHelp.toggle()
                    } label: {
                        Text("How to Play")
                            .font(.system(.title3, design: .rounded).weight(.semibold))
                    }
                    .padding(.vertical, 20)
                    .sheet(isPresented: $showingHelp) {
                        HowToPlay()
                            .presentationDetents([.large, .medium])
                    }

                }
            }
        }
    }
}

struct GameModeButton: View {
    @Binding var showingView: GameViews
    
    let name: String
    let systemImage: String
    let highScore: Int
    let target: GameViews
    
    var body: some View {
        Button {
            showingView = target
        } label: {
            HStack(alignment: .center) {
                Label(name, systemImage: systemImage)
                    .font(.system(.title2, design: .rounded).weight(.medium))
                Spacer()
                HStack {
                    Text("High Score")
                        .font(.system(.headline, design: .rounded).weight(.regular))
                        .foregroundStyle(.gray)
                    Text("\(highScore)")
                        .font(.system(.headline, design: .rounded).weight(.medium))
                        .foregroundStyle(.black)
                }
            }
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 15)
        .background(.gray.opacity(0.15))
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

struct RecentGamesItem: View {
    let game: CompletedGames
    
    var body: some View {
        VStack {
            // First Line
            HStack {
                Text(game.word.uppercased())
                Spacer()
                Text("SCORE \(game.score)")
            }
            .font(.system(.headline, design: .rounded).weight(.semibold))
            
            // Second line
            HStack {
                Text("\(game.date.formatted(date: .abbreviated, time: .shortened))")
                Spacer()
                HStack(spacing: 3) {
                    Text(game.gamemodeString)
                    Image(systemName: game.gamemodeIcon)
                }
            }
            .font(.system(.callout, design: .rounded))
            .opacity(0.7)
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    GameMenu(showingView: .constant(.menu))
}
