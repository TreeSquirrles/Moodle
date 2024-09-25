//
//  CardsView.swift
//  ViewsAndModifiers
//
//  Created by Seungyoo Kim-Jung on 7/4/24.
//

import SwiftData
import SwiftUI

extension View {
    @ViewBuilder func phoneOnlyNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}

struct CardsView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\Deck.name, order: .reverse)]) var decks: [Deck]
    
    @State private var path:[Card] = [Card]()
    @State private var sortOrder = SortDescriptor(\Card.dateAdded)
    @State private var searchText = ""
    
    @State private var editMode: EditMode = .inactive
    
    enum FilterType {
        case none, deck, tagged
    }
    
//    let filter: FilterType
//    
//    var title: String {
//        switch filter {
//        case .none:
//            "All Cards"
//        case .deck:
//            "Cards in _deckname_"
//        case .tagged:
//            "Cards tagged with _tagname_"
//        }
//    }
    
    var body: some View {
        NavigationStack(path: $path) {
            CardListView(sort: sortOrder, searchString: searchText)
                .environment(\.editMode, $editMode)
                .navigationTitle("All Cards")
                .navigationDestination(for: Card.self, destination: { item in
                    CardEditView(card: item)
                })
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
    
    init() {
//        self.filter = filter
    }
    
    
//    func addSamples() {
//        let rome = Card(front: "Rome")
//        let florence = Card(front: "Florence")
//        let naples = Card(front: "Naples")
//        
//        modelContext.insert(rome)
//        modelContext.insert(florence)
//        modelContext.insert(naples)
//    }
    
    func addCard() {
        // Look if there is a deck with id = 0 and with name "Unassigned". If not, add it.
        var unassignedDeckExist: Bool = false
        var ddd: Deck?
        for d in decks {
            if d.id == 0 //&& d.name == "Unassigned"
            {
                unassignedDeckExist = true
                ddd = d
                break
            }
        }
        
        if !unassignedDeckExist{
            let deck = Deck(id: 0, name: "Unassigned")
            modelContext.insert(deck)
            ddd = deck
        }
        
        
        
        let card = Card(deck: ddd)
        modelContext.insert(card)
        path = [card]
    }
    
}

#Preview {
    CardsView()
}
