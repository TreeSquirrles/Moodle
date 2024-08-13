//
//  DeckListView.swift
//  ViewsAndModifiers
//
//  Created by Seungyoo Kim-Jung on 7/12/24.
//

import SwiftData
import SwiftUI

struct DeckListView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query(sort: [SortDescriptor(\Deck.name)]) var decks: [Deck]
    
    var body: some View {
        List {
            ForEach(decks) { deck in
                NavigationLink(value: deck) {
                    VStack(alignment: .leading) {
                        Text(deck.name)
                            .font(.headline)
                        
                        Text("\(deck.cards.count) cards")
                    }
                }
            }
            .onDelete(perform: deleteDecks)
        }
    }
    
    func deleteDecks(_ indexSet: IndexSet) {
        for index in indexSet {
            let deck = decks[index]
            modelContext.delete(deck)
        }
    }
}

#Preview {
    DeckListView()
}
