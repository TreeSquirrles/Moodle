//
//  CardsInTagsView.swift
//  ViewsAndModifiers
//
//  Created by Seungyoo Kim-Jung on 7/6/24.
//

import SwiftUI
import SwiftData

struct CardsInTagsView: View {
    @Environment(\.modelContext) var modelContext
    
    @Bindable var tag: Tag
    
    @State private var isStudying = false
    
    var body: some View {
        VStack {
            if isStudying == false {
                Form {
                    Section("Name") {
                        TextField("Tag Name", text: $tag.tagName)
                    }
                    
                    List {
                        ForEach(tag.cards) { card in
                            NavigationLink(value: card) {
                                VStack(alignment: .leading) {
                                    Text(card.front)
                                        .font(.headline)
                                    
                                    Text(card.dateAdded.formatted())
                                }
                                .navigationTitle(tag.tagName)
                                //                    .navigationDestination(for: Card.self, destination: CardInTagEditView.init)
                            }
                        }
                        .onDelete(perform: removeCardsFromTag)
                    }
                }
                .toolbar {
                    Button("Study") {
                        isStudying = true
                    }
                }
            } else {
                StudyTagView(tag: tag)
                    .toolbar {
                        Button("Done Studying") {
                            isStudying = false
                        }
                    }
            }
        }
        //    CardListView(sort: SortDescriptor(\Card.dateAdded), searchString: "")
        //        .navigationTitle("Tagggg")
                //.navigationDestination(for: Card.self, destination: CardEditView.init)
                //.searchable(text: $searchText)
//                .toolbar {
//                    Button("Add Samples", action: addSamples)
//                    Button("Add Card", systemImage: "plus", action: addCard)
//                    
//                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
//                        Picker("Sort", selection: $sortOrder) {
//                            Text("Name")
//                                .tag(SortDescriptor(\Card.front))
//                            
//                            Text("Date")
//                                .tag(SortDescriptor(\Card.dateAdded))
//                        }
//                        .pickerStyle(.inline)
//                    }
//                }
//        }
        
    }
    
    init(taginput: Tag){
        self.tag = taginput
        print("====")
        print(self.tag.tagName)
        print("----")
    }
    

    
    func removeCardsFromTag(_ indexSet: IndexSet) {
        for index in indexSet {
            let card = tag.cards[index]
            tag.cards.remove(at: index)
        }
    }
}

#Preview {
    CardsInTagsView(taginput: Tag(tagName: ""))
}
