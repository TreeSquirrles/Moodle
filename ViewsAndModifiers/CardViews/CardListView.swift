//
//  CardListView.swift
//  ViewsAndModifiers
//
//  Created by Seungyoo Kim-Jung on 7/4/24.
//

import SwiftData
import SwiftUI

struct CardListView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\Card.dateAdded, order: .reverse), SortDescriptor(\Card.front)]) var cards: [Card]
    
    var body: some View {
        List {
            ForEach(cards) { card in
                NavigationLink(value: card) {
                    VStack(alignment: .leading) {
                        Text(card.front)
                            .font(.headline)
    
                        Text("\(card.dateAdded.formatted())")
                    }
                }
            }
            .onDelete(perform: deleteCards)
        }
    }
    
    init(sort: SortDescriptor<Card>, searchString: String) {
        _cards = Query(filter: #Predicate {
            if searchString.isEmpty {
                return true
            } else {
                return $0.front.localizedStandardContains(searchString)
            }
        }, sort: [sort])
//        print("----====-0009999")
//        print(cards.count)
    }
    
    func deleteCards(_ indexSet: IndexSet) {
        for index in indexSet {
            let card = cards[index]
            modelContext.delete(card)
        }
    }
}

#Preview {
    CardListView(sort: SortDescriptor(\Card.dateAdded), searchString: "")
}
