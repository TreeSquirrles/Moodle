//
//  CardEditView.swift
//  ViewsAndModifiers
//
//  Created by Seungyoo Kim-Jung on 7/4/24.
//


import SwiftData
import SwiftUI

struct CardEditView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var card: Card
    @State private var newTagName = ""
    @Query(sort: [SortDescriptor(\Tag.tagName)]) var tags: [Tag]
    
    var body: some View {
        Form {
            TextField("Name", text: $card.front)
            TextField("Details", text: $card.back, axis: .vertical)
            DatePicker("Date", selection: $card.dateAdded)
            
//            Section("Level") {
//                Picker("Level", selection: $card.priority) {
//                    Text("Super ez").tag(1)
//                    Text("ez").tag(2)
//                    Text("difficult").tag(3)
//                    Text("Super difficult").tag(4)
//                }
//                .pickerStyle(.segmented)
//            }
            
            Section("Tags") {
                ForEach(card.tags) { tag in
                    Text(tag.tagName)
                }
                .onDelete(perform: removeTags)
                
                HStack {
                    TextField("Add a new sight in \(card.front)", text: $newTagName)
                    
                    Button("Add", action: addTag)
                }
            }
        }
        .navigationTitle("Edit Card")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    init(card: Card) {
        self.card = card
        _tags = Query()
    } // beeeeep
    
    func addTag() {
        guard newTagName.isEmpty == false else { return }
        
        withAnimation {
            let tag = Tag(tagName: newTagName)
            card.tags.append(tag)
            newTagName = ""
        }
        try? modelContext.save()
    }
    
    func removeTags(_ indexSet: IndexSet) {
        for index in indexSet {
            let tag = card.tags[index]
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
