//
//  StudyTagView.swift
//  ViewsAndModifiers
//
//  Created by Seungyoo Kim-Jung on 10/5/24.
//

import SwiftUI
import SwiftData

struct StudyTagView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    
    //@State private var cards = Array<CardTest>(repeating: .example, count: 10)
    @State private var isActive = true
    @Bindable var tag: Tag
    @State private var numCards: Int
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(red: 0.5, green: 0.7, blue: 0.9), Color(red: 0.4, green: 0.5, blue: 0.9)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            //WhiteCardView()
            ForEach(0..<tag.cards.count, id: \.self) { index in
                WhiteCardView(card: tag.cards[index]) {
                    withAnimation {
                        removeCard(at: index)
                    }
                }
                .stacked(at: index, in: numCards)
                .allowsHitTesting(index == numCards - 1)
                .accessibilityHidden(index < numCards - 1)
            }
            
            if accessibilityDifferentiateWithoutColor || accessibilityVoiceOverEnabled {
                VStack {
                    Spacer()
                    HStack {
                        Button {
                            withAnimation {
                                removeCard(at: numCards - 1)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as being incorrect.")
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                removeCard(at: numCards - 1)
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityLabel("Mark your answer as being correct.")
                    }
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
    }
    
    init(tag: Tag) {
        self.tag = tag
        self.numCards = tag.cards.count
    }
    
    func removeCard(at index: Int) {
        guard index >= 0 else { return }
        
        numCards -= 1
        
        if numCards == 0 {
            isActive = false
        }
    }
}


