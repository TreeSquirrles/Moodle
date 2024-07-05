//
//  CardsView.swift
//  ViewsAndModifiers
//
//  Created by Seungyoo Kim-Jung on 7/4/24.
//

import SwiftUI
import SwiftData


struct CardsView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var path = [Card]()
    @State private var sortOrder = SortDescriptor(\Card.dateAdded, order: .reverse)
    @State private var searchText = ""
    
    enum FilterType {
        case none, deck, tagged
    }
    
    let filter: FilterType
    
    var title: String {
        switch filter {
        case .none:
            "All Cards"
        case .deck:
            "Cards in _deckname_"
        case .tagged:
            "Cards tagged with _tagname_"
        }
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            CardListView(sort: sortOrder, searchString: searchText)
                .navigationTitle("Title Text")
                .navigationDestination(for: Card.self, destination: CardEditView.init)
                .searchable(text: $searchText)
                .toolbar {
                    Button("Add Samples", action: addSamples)
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
            .navigationTitle(title)
        }
    }
    
    func addSamples() {
        let rome = Card(front: "Rome")
        let florence = Card(front: "Florence")
        let naples = Card(front: "Naples")
        
        modelContext.insert(rome)
        modelContext.insert(florence)
        modelContext.insert(naples)
    }
    
    func addCard() {
        let card = Card()
        modelContext.insert(card)
        path = [card]
    }
    
}

#Preview {
    CardsView(filter: .none)
}
