//
//  CardEditView.swift
//  ViewsAndModifiers
//
//  Created by Seungyoo Kim-Jung on 7/4/24.
//


import SwiftData
import SwiftUI

struct DeckChooseView: View {
    var decks: [Deck]
    @Bindable var card: Card
    
    var body: some View {
        if decks.isEmpty {
            Text("Hello!, please don't be sad, but you haven't created a deck yet. Please go to the decks tab to create your deck.")
        } else {
            Picker("Deck Choose", selection: $card.deck) {
                ForEach(decks) {
                    deck in
                    Text(deck.name)
                }
            }
        }
    }
}


struct CardEditView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var card: Card
    @State private var newTagName = ""
    
    @Query(sort: [SortDescriptor(\Tag.tagName)]) var tags: [Tag]
    @Query(sort: [SortDescriptor(\Deck.name)]) var decks: [Deck]
    
    @State private var duplicateTagAlert: Bool = false
    
    var body: some View {
        Form {
            TextField("Name", text: $card.front)
            TextField("Details", text: $card.back, axis: .vertical)
            
            //            Section("Level") {
            //                Picker("Level", selection: $card.priority) {
            //                    Text("Super ez").tag(1)
            //                    Text("ez").tag(2)
            //                    Text("difficult").tag(3)
            //                    Text("Super difficult").tag(4)
            //                }
            //                .pickerStyle(.segmented)
            //            }
            
            
            
            NavigationLink(destination:DeckChooseView(decks: decks, card: card)) {
                Text("Choose your deck (required)")
            }
            
//            Section("Card Drawing") {
//                NavigationLink(destination: CardDrawingView()) {
//                    Text("Draw front and back")
//                }
//                .navigationDestination(for: Card.self, destination: { item in  CardDrawingView()})
//            }
            
            
            Section("Tags") {
                
                ForEach(card.tags) { tag in
                    Text(tag.tagName)
                }
                .onDelete(perform: removeTags)
                
                HStack {
                    TextField("Put a tag on \(card.front)", text: $newTagName)
                    
                    Button("Add", action: addTag)
                }
            }
        }
        .navigationTitle("Edit Card")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Duplicate Tag", isPresented: $duplicateTagAlert){
            Button("I understand", role: .cancel) {}
        } message: {
            Text("You tried to add a tag that is already tagged on this card")
        }
    }
    
    init(card: Card) {
        self.card = card
        _tags = Query()
    }
    
    func addTag() {
        guard newTagName.isEmpty == false else { return }
        for tag in card.tags {
            if tag.tagName == newTagName
            {
                duplicateTagAlert = true
                return
            }
        }
        
        var t: Tag?
        
        for tag in tags
        {
            if tag.tagName == newTagName
            {
                t = tag
                break
            }
            t = nil
        }
        
        withAnimation {
            
            let tag = t ?? Tag(tagName: newTagName)
            card.tags.append(tag)
            
        }
        newTagName = ""
        try? modelContext.save()
    }
    
    func removeTags(_ indexSet: IndexSet) {
        for index in indexSet {
            //let tag = card.tags[index]
            card.tags.remove(at: index)
            // modelContext.delete(tag)
            try? modelContext.save()
            for tag in tags {
                print(tag.tagName)
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Card.self, configurations: config)
        let example = Card()
        
        return CardEditView(card: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
