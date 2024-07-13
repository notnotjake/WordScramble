//
//  HistoryView.swift
//  WordScramble
//
//  Created by Jake Go on 7/13/24.
//

import SwiftUI

struct HistoryView: View {
    //TODO: save words in model
    let recentGames: [CompletedGames] = [
        CompletedGames(word: "audibles", score: 64, date: Date.now, gamemode: .frantic),
        CompletedGames(word: "regrades", score: 37, date: Date.now, gamemode: .timed),
        CompletedGames(word: "shouting", score: 140, date: Date.now, gamemode: .zen),
        CompletedGames(word: "audibles", score: 50, date: Date.now, gamemode: .frantic),
        CompletedGames(word: "regrades", score: 43, date: Date.now, gamemode: .timed),
        CompletedGames(word: "shouting", score: 90, date: Date.now, gamemode: .zen)
    ]
    
    var body: some View {
        List {
            Group {
                Section {
                    LifetimeStatistics()
                }
                
                Section {
                    if recentGames.isEmpty {
                        Text("Completed Games Will Show Up Here")
                    }
                    ForEach(recentGames, id: \.self) { game in
                        RecentGamesItem(game: game)
                    }
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button("Delete", role: .destructive) {
                            //TODO: Implement deleting saved words
                        }
                        .tint(.red)
                    }
                    .swipeActions(edge: .leading) {
                        Button("Replay") {
                            //TODO: Implement reusing words
                        }
                        .tint(.green)
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
}

struct LifetimeStatistics: View {
    var body: some View {
        HStack(alignment: .center) {
            VStack {
                Text("Lifetime Stats".uppercased())
                    .font(.system(.callout, design: .rounded).weight(.bold))
                    .foregroundStyle(.primary.opacity(0.6))
                    .padding(.bottom, 5)
                HStack(spacing: 50) {
                    StatItem(name: "Time", value: "2:35hrs")
                    StatItem(name: "Words", value: "98")
                    StatItem(name: "Games", value: "15")
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}
struct StatItem: View {
    var name: String
    var value: String
    var body: some View {
        VStack(spacing: 0) {
            Text("\(value)")
                .font(.system(.headline, design: .rounded).weight(.semibold))
            Text("\(name)")
        }
    }
}

#Preview {
    HistoryView()
}
