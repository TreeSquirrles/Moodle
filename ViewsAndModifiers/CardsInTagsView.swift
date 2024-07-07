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
    //@Query var cards: [Card]
    //@Query var tags: [Tag]
    
    @Bindable var tag: Tag
    //@State private var path = [Card]()
    
    
    
    var body: some View {
        //Text("Hello, World!")
        List {
            ForEach(tag.cards) { card in
                NavigationLink(value: card) {
                    VStack(alignment: .leading) {
                        Text(card.front)
                            .font(.headline)
                        
                        Text(card.dateAdded.formatted())
                        //("\(tag.cards.count)")
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
        
        
        //_cards = Query()
//
//        _tags = Query(filter: #Predicate {
//            if taginput.tagName.isEmpty {
//                return false
//            } else {
//                return $0.tagName.localizedStandardContains( taginput.tagName)
//            }
//        })
        
        
        //var bbb = false
//        _cards = Query(filter: #Predicate {
//            //bbb = false
////            ForEach($0.tags) { tag in
////                if tag.tagName.localizedStandardContains( taginput.tagName) {
////                    bbb = true
////                }
////            }
//            return true
//        })
    }
    

    
    func removeCardsFromTag(_ indexSet: IndexSet) {
        for index in indexSet {
            let card = tag.cards[index]
            // // Do something to remove card from the deck
            //modelContext.delete(card)
            
        }
    }
}

#Preview {
    CardsInTagsView(taginput: Tag(tagName: ""))
}
