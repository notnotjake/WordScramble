//
//  ContentView.swift
//  WordScramble
//
//  Created by Jake Go on 7/1/24.
//

import SwiftUI

struct PlaygroundView: View {
    @State private var selection = 1
    let people = ["Finn", "Leia", "Luke", "Ray"]
    
    var body: some View {
        VStack {
            VStack {
                Text("Saturday")
                    .bold()
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .frame(maxWidth: .infinity)
                    .background(.primary.opacity(0.07))
                    .clipShape(RoundedRectangle(cornerRadius: 9))
                
                VStack {
                    Text("10,000")
                        .font(.system(.largeTitle, design: .rounded).weight(.semibold))
                    Text("Items")
                        .font(.system(.headline, design: .rounded).weight(.medium))
                        .foregroundStyle(.primary.opacity(0.7))
                }
                .padding(.vertical, 30)
                HStack {
                    Picker("Target", selection: $selection) {
                        ForEach(0..<7) { num in
                            Text("\(num) Questions")
                        }
                    }
                    Button {
                        // todo
                    } label: {
                        Image(systemName: "arrow.right.circle.fill")
                            .foregroundStyle(.gray)
                    }
                }
            }
            
        }
        .padding(9)
        .padding(.bottom, 10)
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(.primary.opacity(0.15), lineWidth: 2)
        )
        .cornerRadius(18.0)
        .frame(maxWidth: 300)
    }
}

#Preview {
    PlaygroundView()
}
