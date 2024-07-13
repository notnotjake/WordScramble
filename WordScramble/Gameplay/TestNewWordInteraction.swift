//
//  TestNewWordInteraction.swift
//  WordScramble
//
//  Created by Jake Go on 7/12/24.
//

import SwiftUI
import UIKit

struct DictionaryLookup: UIViewControllerRepresentable {
    let word: String
    
    func makeUIViewController(context: Context) -> UIReferenceLibraryViewController {
        return UIReferenceLibraryViewController(term: word)
    }
    
    func updateUIViewController(_ uiViewController: UIReferenceLibraryViewController, context: Context) {}
}

struct TestNewWordInteraction: View {
    @Binding var rootWord: String
    @State private var pastWords: [String] = []
    @State private var pastWordsIndex: Int = 0
    
    @State private var dragAmount = CGSize.zero
    @State private var isDragged = false
    @State private var rotationAngle: Angle = Angle(degrees: 0)
    
    @State private var isShowingDictionaryLookup = false
    
    var body: some View {
        ZStack {
            if isDragged {
                HStack {
                    Image(systemName: "arrowshape.backward.fill")
                    Spacer()
                    Image(systemName: "arrow.clockwise.circle.fill")
                }
                .font(.title)
                .foregroundStyle(HSBColor(hue: 200, saturation: 90, brightness: 98).color)
                .padding(.horizontal)
            }
            
            Text("\(rootWord)".uppercased())
                .font(.system(.largeTitle, design: .rounded).weight(.semibold))
                .containerRelativeFrame(.horizontal, count: 12, span: 8, spacing: 10)
                .padding(.vertical, 5)
                .background(.thinMaterial.opacity(isDragged ? 1.0 : 0.0))
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .onAppear(perform: seedWord)
                .onTapGesture {
                    seedWord()
                }
                .rotationEffect(rotationAngle)
                .offset(dragAmount)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            dragAmount.width = value.translation.width
                            // Uses a logarithmic function to slow down the vertical drag after a certain point
                            dragAmount.height = 30 * log(abs(value.translation.height) / 30 + 1) * (value.translation.height < 0 ? -1 : 1)
                            rotationAngle = Angle(degrees: value.translation.width / 20)
                            withAnimation(.easeIn(duration: 0.15)) {
                                isDragged = true
                            }
                        }
                        .onEnded { value in
                            if dragAmount.width < -20 && !pastWords.isEmpty {
                                if pastWordsIndex < pastWords.count {
                                    pastWordsIndex += 1
                                }
                                rootWord = pastWords[pastWords.count - pastWordsIndex]
                            }
                            else {
                                seedWord()
                                pastWordsIndex = 0
                            }
                            
                            withAnimation(.bouncy(duration: 0.35)) {
                                dragAmount = .zero
                                rotationAngle = Angle(degrees: 0)
                                isDragged = false
                            }
                        }
                )
                .contextMenu {
                    Button{
                        seedWord()
                    } label: {
                        Label("Get New Word", systemImage: "arrow.clockwise.circle.fill")
                    }
                    Divider()
                    Button{
                        isShowingDictionaryLookup = true
                    } label: {
                        Label("Look Up", systemImage: "magnifyingglass")
                    }
                    Button {
                        // add to saved words list
                    } label: {
                        Label("Save Word", systemImage: "square.and.arrow.down")
                    }
                }
                .sheet(isPresented: $isShowingDictionaryLookup) {
                    DictionaryLookup(word: rootWord)
                }
        }
        .frame(maxWidth: .infinity)
    }
    
    func seedWord () {
        if !rootWord.isEmpty {
            pastWords.append(rootWord)
            print(pastWords)
        }
        rootWord = generateWord()
    }
}

#Preview {
    TestNewWordInteraction(rootWord: .constant("TEST"))
}
