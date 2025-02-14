//
//  StudyView.swift
//  ViewsAndModifiers
//
//  Created by Seungyoo Kim-Jung on 8/31/24.
//

import SwiftData
import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: offset * 1, y: offset * 1.5)
    }
}

struct StudyView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    
    //@State private var cards = Array<CardTest>(repeating: .example, count: 10)
    @State private var isActive = true
    @Bindable var deck: Deck
    @State private var numCards: Int
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(red: 0.5, green: 0.7, blue: 0.9), Color(red: 0.4, green: 0.5, blue: 0.9)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            //WhiteCardView()
            ForEach(0..<deck.cards.count, id: \.self) { index in
                WhiteCardView(card: deck.cards[index]) {
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
    
    init(deck: Deck) {
        self.deck = deck
        self.numCards = deck.cards.count
    }
    
    func removeCard(at index: Int) {
        guard index >= 0 else { return }
        
        numCards -= 1
        
        if numCards == 0 {
            isActive = false
        }
    }
}

#Preview {
    StudyView(deck: Deck(name: "Study deck"))
}
