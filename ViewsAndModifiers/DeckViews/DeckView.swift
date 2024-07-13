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
    @State private var path:[Deck] = [Deck]()
    @Bindable var deck: Deck
    
    @State private var sortOrder = SortDescriptor(\Deck.name)
    @State private var searchText = ""
    
    @State private var editMode: EditMode = .inactive
    
    @Query(sort: [SortDescriptor(\Deck.name)]) var decks: [Deck]
    
    var body: some View {
        NavigationView{
            DeckListView()
                .environment(\.editMode, $editMode)
                .navigationTitle("Decks")
                .navigationDestination(for: Deck.self, destination: { item in
                    CardsInDeckView(deckinput: item)
                }) // Deal with this later
                .searchable(text: $searchText)
                .toolbar {
                    //Button("Add Samples", action: addSamples)
                    
                    Button(action: {
                        editMode.toggleEditMode(&editMode)
                    }) {
                        Label("Delete Tag", systemImage: "trash.fill")
                    }
                    .tint(editMode == .inactive ? .blue : .red)
                    
                    Button("Add Card", systemImage: "plus", action: addCard)
                    
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Name")
                                .tag(SortDescriptor(\Card.front))
                            
                            Text("Date")
                                .tag(SortDescriptor(\Card.dateAdded))
                        }
                        .pickerStyle(.inline)
                    }
                }
        }
    }
    
    init(deck: Deck = Deck(name: "My Deck")) {
        self.deck = deck
    }
    
    func addSamples() {
        let italy = Deck(name: "Italy")
        let france = Deck(name: "France")
        let spain = Deck(name: "Spain")
        
        modelContext.insert(italy)
        modelContext.insert(france)
        modelContext.insert(spain)
    }
    
    func addCard() {
        let deck = Deck()
        modelContext.insert(deck)
        path = [deck]
    }
}

//#Preview {
//    DeckView(deck: Deck())
//}
