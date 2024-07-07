//
//  TagListView.swift
//  ViewsAndModifiers
//
//  Created by Seungyoo Kim-Jung on 7/5/24.
//

import SwiftData
import SwiftUI

struct TagListView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\Tag.tagName)]) var tags: [Tag]
    
    var body: some View {
        List {
            ForEach(tags) { tag in
                NavigationLink(value: tag) {
                    VStack(alignment: .leading) {
                        Text(tag.tagName)
                            .font(.headline)
                        Text("\(tag.cards.count) cards")
                    }
                }
            }
            .onDelete(perform: deleteCards)
        }
    }
    
    init(searchString: String) {
        _tags = Query(filter: #Predicate {
            if searchString.isEmpty {
                return true
            } else {
                return $0.tagName.localizedStandardContains(searchString)
            }
        }, sort: [SortDescriptor(\Tag.tagName)])
    }
    
    func deleteCards(_ indexSet: IndexSet) {
        for index in indexSet {
            let tag = tags[index]
            modelContext.delete(tag)
        }
    }
}

#Preview {
    TagListView(searchString: "")
}
