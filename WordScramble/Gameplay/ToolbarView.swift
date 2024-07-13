//
//  ToolbarView.swift
//  WordScramble
//
//  Created by Jake Go on 7/10/24.
//

import SwiftUI

public enum FocusedField: Hashable {
    case newWordField
}

struct ToolbarView: View {
    
    @Binding var showingView: GameViews
    @FocusState var focusedField: FocusedField?
    
    var body: some View {
        HStack {
            Menu {
                Button {
                    // Do Nothing
                } label: {
                    Label("Keep Playing", systemImage: "play.fill")
                }
                Button(role: .destructive) {
                    showingView = .menu
                } label: {
                    Label("Quit and Discard", systemImage: "trash.fill")
                }
            } label: {
                Label("Quit", systemImage: "xmark.circle.fill")
            }
                .labelStyle(.iconOnly)
                .foregroundStyle(.gray)
                .font(.title2)
            
            Spacer()
            
            if focusedField == FocusedField.newWordField {
                Button {
                    focusedField = nil
                } label: {
                    Label("Hide Keyboard", systemImage: "keyboard.chevron.compact.down.fill")
                }
                .labelStyle(.iconOnly)
                .foregroundStyle(.gray)
                .font(.title2)
            }
        }
        .frame(minHeight: 40)
        .padding(.horizontal, 20)
    }
}

#Preview {
    ToolbarView(showingView:.constant(.frantic))
}
