//
//  PercentageBar.swift
//  WordScramble
//
//  Created by Jake Go on 7/8/24.
//

import SwiftUI

public struct ProgressBar: View {
    let height: Double = 4.0
    var progress: Double = 1.0
    var highlightColor: Color = .green
    
    public var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray.tertiary)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            GeometryReader { metrics in
                HStack(spacing: 0) {
                    Rectangle()
                        .fill(highlightColor)
                        .frame(maxWidth: metrics.size.width * progress, maxHeight: .infinity, alignment: .center)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .frame(maxHeight: height)
    }
}

#Preview {
    ProgressBar()
}
