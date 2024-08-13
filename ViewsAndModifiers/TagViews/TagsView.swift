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
    @State private var path = NavigationPath() // [Tag]()
    
    @State private var sortOrder = SortDescriptor(\Tag.tagName)
    @State private var searchText = ""
    
    @State private var editMode: EditMode = .inactive
    
    var body: some View {
        NavigationStack(path: $path) {
            TagListView(searchString: searchText)
                .environment(\.editMode, $editMode)
                .navigationTitle("Tags")
                .navigationDestination(for: Tag.self, destination: CardsInTagsView.init) // it just uses the for variable as the parameter for the init func
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
    
    func addTag() {
        let tag = Tag()
        modelContext.insert(tag)
        //path.append(tag)
    }
}

#Preview {
    TagsView()
}
