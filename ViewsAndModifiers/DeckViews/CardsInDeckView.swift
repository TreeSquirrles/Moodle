//
//  CardsInDeckView.swift
//  ViewsAndModifiers
//
//  Created by Seungyoo Kim-Jung on 7/12/24.
//

import SwiftData
import SwiftUI

struct CardsInDeckView: View {
    @Environment(\.modelContext) var modelContext
    
    @Bindable var deck: Deck
    
    var body: some View {
        List {
            Section("Name") {
                TextField("Tag Name", text: $deck.name)
            }
            
            ForEach(deck.cards) { card in
                NavigationLink(value: card) {
                    VStack(alignment: .leading) {
                        Text(card.front)
                            .font(.headline)
                        
                        Text(card.dateAdded.formatted())
                    }
                    .navigationTitle(deck.name)
//                    .navigationDestination(for: Card.self, destination: CardEditView.init)
                }
            }
            .onDelete(perform: removeCardsFromDeck)
            .toolbar {
                Button("Study") {
                    
                }
            }
        }
    }
    
    init(deckinput: Deck){
        self.deck = deckinput
    }
    

    
    func removeCardsFromDeck(_ indexSet: IndexSet) {
        for index in indexSet {
            let card = deck.cards[index]
            deck.cards.remove(at: index)
        }
    }
}

#Preview {
    CardsInDeckView(deckinput: Deck(name: "My Deck"))
}
