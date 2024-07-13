//
//  DeckEditView.swift
//  ViewsAndModifiers
//
//  Created by TreeSquirrles on 7/9/24.
//

import SwiftData
import SwiftUI

struct DeckEditView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var deck: Deck
    @State private var newDeckName = ""
    
    
    
    var body: some View {
        Form {
            TextField("Name", text: $deck.name)
            
            Section("Cards") {
                ForEach(deck.cards) { card in
                    Text(card.front)
                }
            }
        }
    }
    
    
    init(deck: Deck) {
        self.deck = deck
    }
}

//#Preview {
//    DeckEditView()
//}
