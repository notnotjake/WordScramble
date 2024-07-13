//
//  HowToPlay.swift
//  WordScramble
//
//  Created by Jake Go on 7/8/24.
//

import SwiftUI

struct HowToPlay: View {
    var exampleWord: String {
        generateWord()
    }
    
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    Text("You'll Get an 8-Letter Word")
                        .font(.system(.title2, design: .rounded).weight(.bold))
                        .foregroundStyle(.primary.opacity(0.7))
                    Text("\(exampleWord)".uppercased())
                        .font(.system(.largeTitle, design: .rounded).weight(.semibold))
                        .padding(.vertical, 1)
                }
                .padding(.top, 50)
                .padding(.vertical, 20)
                
                VStack {
                    VStack {
                        Group {
                            Text("Then make new words using the letters from that root word")
                            Text("Tap on the word to get a new one")
                            Text("Earn points with longer words")
                        }
                        .font(.system(.title3, design: .rounded).weight(.medium))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                    }
                    .padding(.bottom, 30)
                    
                    VStack {
                        HStack(spacing: 3) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(.green)
                                .font(.title2)
                            Text("Your Words Must Be:")
                                .font(.system(.title2, design: .rounded).weight(.medium))
                        }
                        .padding(.bottom, 3)
                        
                        Group {
                            Text("Four or more letters long")
                            Text("Found in the dictionary")
                            Text("Created from the start word's letters")
                        }
                        .font(.system(.headline, design: .rounded).weight(.regular))
                        .multilineTextAlignment(.center)
                        .padding(2)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(LinearGradient(colors: [
                        HSBColor(hue: 129, saturation: 13, brightness: 100).color,
                        HSBColor(hue: 159, saturation: 6, brightness: 100).color
                        ], startPoint: .top, endPoint: .bottom))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                .padding(.bottom)
                
                Divider()
                
                VStack {
                    Text("Choosing a Gamemode")
                        .font(.system(.title2, design: .rounded).weight(.bold))
                        .foregroundStyle(.primary.opacity(0.7))
                    
                    gameModeCard(
                        name: "Zen",
                        icon: "circle.circle.fill",
                        tags: ["Easy", "Laid Back"],
                        description: "Play at your own pace without any time limits. You can get a new word at any time.",
                        gradientTop: HSBColor(hue: 201, saturation: 20, brightness: 98),
                        gradientBottom: HSBColor(hue: 216, saturation: 10, brightness: 100))
                    
                    gameModeCard(
                        name: "Timed",
                        icon: "stopwatch.fill",
                        tags: ["Easy", "Fast Paced"],
                        description: "Get as many words as you can within the time limit. You can get a new word at any time.",
                        gradientTop: HSBColor(hue: 50.0, saturation: 17.0, brightness: 99.0),
                        gradientBottom: HSBColor(hue: 32.0, saturation: 9.0, brightness: 98.0))
                    
                    gameModeCard(
                        name: "Frantic",
                        icon: "bolt.circle.fill",
                        tags: ["Hard", "Rapid Paced"],
                        description: "You start with 30 seconds to make words and will get 10 seconds every time you get a new word. The game ends when you run out of time.",
                        gradientTop: HSBColor(hue: 21.0, saturation: 14.0, brightness: 100),
                        gradientBottom: HSBColor(hue: 360.0, saturation: 7.0, brightness: 100.0))
                }
                .padding(.vertical)
            }
            .padding(.horizontal)
        }
    }
}

struct HSBColor {
    let hue: Double
    let saturation: Double
    let brightness: Double
    
    var color: Color {
        Color(hue: hue / 360.0, saturation: saturation / 100.0, brightness: brightness / 100.0 )
    }
}
struct gameModeCard: View {
    let name: String
    let icon: String
    let tags: [String]
    let description: String
    let gradientTop: HSBColor
    let gradientBottom: HSBColor
    
    var body: some View {
        VStack {
            Label(name, systemImage: icon)
                .font(.system(.title2, design: .rounded).weight(.medium))
                .foregroundStyle(.blue)
            HStack {
                Group {
                    ForEach(tags, id: \.self) { tag in
                        Text(tag)
                    }
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .font(.system(.callout, design: .rounded))
                .background(.background)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
            }
            .padding(5)
            
            Text("\(description)")
                .frame(maxWidth: .infinity)
                .font(.system(.headline, design: .rounded).weight(.regular))
                .padding(.vertical)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(LinearGradient(colors: [gradientTop.color, gradientBottom.color], startPoint: .top, endPoint: .bottom))
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    HowToPlay()
}
