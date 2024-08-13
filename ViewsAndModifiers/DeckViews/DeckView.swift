//
//  DeckView.swift
//  ViewsAndModifiers
//
//  Created by TreeSquirrles on 7/9/24.
//

import SwiftData
import SwiftUI

struct DeckView: View {
    @Environment(\.modelContext) var modelContext
    @State private var path = NavigationPath()
    @Bindable var deck: Deck
    
    @State private var sortOrder = SortDescriptor(\Deck.name)
    @State private var searchText = ""
    @State private var editMode: EditMode = .inactive
    
    @Query(sort: [SortDescriptor(\Deck.name)]) var decks: [Deck]
    
    var body: some View {
        NavigationStack {
            DeckListView()
                .environment(\.editMode, $editMode)
                .navigationTitle("Decks")
                .navigationDestination(for: Deck.self, destination: { item in
                    CardsInDeckView(deckinput: item)
                }) // Deal with this later
                .navigationDestination(for: Card.self, destination: CardEditView.init)
                .searchable(text: $searchText)
                .toolbar {
                    //Button("Add Samples", action: addSamples)
                    
                    Button(action: {
                        editMode.toggleEditMode(&editMode)
                    }) {
                        Label("Delete Tag", systemImage: "trash.fill")
                    }
                    .tint(editMode == .inactive ? .blue : .red)
                    
                    Button("Add Deck", systemImage: "plus", action: addDeck)
                    
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Deck")
                                .tag(SortDescriptor(\Deck.name))
                            
                            Text("Cards")
                                .tag(SortDescriptor(\Deck.cards.count))
                        }
                        .pickerStyle(.inline)
                    }
                }
            
        }
    }
    
    init(deck: Deck = Deck(name: "My Deck")) {
        self.deck = deck
    }
    
    func addDeck() {
        let deck = Deck()
        modelContext.insert(deck)
        path.append(deck)
    }
}

//#Preview {
//    DeckView(deck: Deck())
//}
