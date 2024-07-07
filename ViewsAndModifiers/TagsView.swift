//
//  TagsView.swift
//  ViewsAndModifiers
//
//  Created by Seungyoo Kim-Jung on 7/5/24.
//

import SwiftData
import SwiftUI

struct TagsView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var path = [Tag]()
    @State private var sortOrder = SortDescriptor(\Tag.tagName)
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
            "In a Tag"
        }
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            TagListView(searchString: searchText)
                .navigationTitle("Tags")
                .navigationDestination(for: Tag.self, destination: CardsInTagsView.init) // ???
                .searchable(text: $searchText)
                .toolbar {
                    Button("Add Samples", action: addSamples)
                    Button("Add Tag", systemImage: "plus", action: addTag)
                    
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Tag")
                                .tag(SortDescriptor(\Tag.tagName))
                            
                            Text("Cards")
                                .tag(SortDescriptor(\Tag.cards.count))
                        }
                        .pickerStyle(.inline)
                    }
                }
            .navigationTitle("Tags")
        }
    }
    
    func addSamples() {
        let italy = Tag(tagName: "Italy")
        let england = Tag(tagName: "England")
        let france = Tag(tagName: "France")
        
        modelContext.insert(italy)
        modelContext.insert(england)
        modelContext.insert(france)
    }
    
    func addTag() {
        let tag = Tag()
        modelContext.insert(tag)
        path = [tag]
    }
}

#Preview {
    TagsView(filter: .tagged)
}
