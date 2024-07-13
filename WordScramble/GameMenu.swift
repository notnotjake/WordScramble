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
    
    let recentGames: [CompletedGames] = [
        CompletedGames(word: "audibles", score: 64, date: Date.now, gamemode: .frantic),
        CompletedGames(word: "regrades", score: 37, date: Date.now, gamemode: .timed),
        CompletedGames(word: "shouting", score: 140, date: Date.now, gamemode: .zen),
        CompletedGames(word: "audibles", score: 50, date: Date.now, gamemode: .frantic),
        CompletedGames(word: "regrades", score: 43, date: Date.now, gamemode: .timed),
        CompletedGames(word: "shouting", score: 90, date: Date.now, gamemode: .zen)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationStack {
                List {
                    Group {
                        Section {
                            HStack {
                                Spacer()
                                VStack {
                                    Text("Lifetime Stats".uppercased())
                                        .font(.system(.callout, design: .rounded).weight(.bold))
                                        .foregroundStyle(.primary.opacity(0.6))
                                        .padding(.bottom, 5)
                                    HStack(spacing: 50) {
                                        VStack(spacing: 0) {
                                            Text("2:35hrs")
                                                .font(.system(.headline, design: .rounded).weight(.semibold))
                                            Text("Time")
                                            
                                        }
                                        VStack(spacing: 0) {
                                            Text("98")
                                                .font(.system(.headline, design: .rounded).weight(.semibold))
                                            Text("Words")
                                        }
                                        VStack(spacing: 0) {
                                            Text("15")
                                                .font(.system(.headline, design: .rounded).weight(.semibold))
                                            Text("Games")
                                        }
                                    }
                                }
                                Spacer()
                            }
                        }
                        
                        Section {
                            ForEach(recentGames, id: \.self) { game in
                                RecentGamesItem(game: game)
                            }
                            .listRowBackground(Color.clear)
                            .listRowInsets(EdgeInsets())
                            .swipeActions(edge: .trailing) {
                                Button("Play") {
                                    //TODO: Implement reusing words
                                }
                                .tint(.green)
                            }
                            .swipeActions(edge: .leading) {
                                Button("View") {
                                    //TODO: Implement reusing words
                                }
                                .tint(.blue)
                            }
                        } header: {
                            Text("Recent Games".uppercased())
                                .font(.system(.callout, design: .rounded).weight(.bold))
                                .foregroundStyle(.primary.opacity(0.8))
                                .padding(.bottom, 5)
                                .padding(.top, 15)
                        }
                    }
                    .listRowBackground(Color.clear)
                    .padding(.horizontal, 10)
                    .listRowInsets(EdgeInsets())
                }
                .listStyle(.insetGrouped)
                .background(.background.secondary)
                
            }
            .navigationTitle("Test")
                
            
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
