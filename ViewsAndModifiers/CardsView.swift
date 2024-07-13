//
//  CardsView.swift
//  ViewsAndModifiers
//
//  Created by Seungyoo Kim-Jung on 7/4/24.
//

import SwiftData
import SwiftUI


struct CardsView: View {
    @Environment(\.modelContext) var modelContext
    
    
    @State private var path:[Card] = [Card]()
    @State private var sortOrder = SortDescriptor(\Card.dateAdded)
    @State private var searchText = ""
    
    @State private var editMode: EditMode = .inactive
    
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
                .environment(\.editMode, $editMode)
                .navigationTitle(title)
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
            .navigationTitle(title)
        }
    }
    
    init(filter: FilterType) {
        self.filter = filter
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
