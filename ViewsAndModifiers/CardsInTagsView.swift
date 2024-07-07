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
    @Query var cards: [Card]
    
    @Bindable var tag: Tag
    @State private var path = [Card]()
    
    
    
    var body: some View {
        //Text("Hello, World!")
        List {
            ForEach(cards) { card in
                NavigationLink(value: card) {
                    VStack(alignment: .leading) {
                        Text(card.front)
                            .font(.headline)
                        
                        Text(card.dateAdded.formatted())
                        Text("\(cards.count)")
                    }
                }
            }
            .onDelete(perform: removeCardsFromTag)
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
        _cards = Query()
//        _cards = Query(filter: #Predicate {
//            if searchString.isEmpty {
//                return true
//            } else {
//                return $0.front.localizedStandardContains(searchString)
//            }
//        }, sort: [sort])
//        print(cards.count)
        //path = [cards[1]]
    }
    
    
    func removeCardsFromTag(_ indexSet: IndexSet) {
        for index in indexSet {
            let card = cards[index]
            // // Do something to remove card from the deck
            //modelContext.delete(card)
            
        }
    }
}

#Preview {
    CardsInTagsView(taginput: Tag(tagName: ""))
}
