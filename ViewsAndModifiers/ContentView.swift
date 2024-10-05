//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by yEETBOI on 6/11/24.
//test

import SwiftData
import SwiftUI

struct Buttonn: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(.black)
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .fontWeight(.semibold)
            .font(.title)
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .fontDesign(.rounded)
            .fontWeight(.heavy)
    }
}

extension View {
    func button() -> some View {
        modifier(Buttonn())
    }
    func title() -> some View {
        modifier(Title())
    }
    func Exit() -> some View {
        Text("Drag here to exit view!")
            .padding()
    }
}

extension EditMode {
    func toggleEditMode(_ editMode: inout EditMode)
    {
        editMode = editMode == .inactive ? .active : .inactive
    }
}

struct ContentView: View { // Homepage
    @Environment(\.modelContext) var modelContext
    
    @State private var showCredits = false
    @State private var showingActionSheet = false
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationView {
            TabView{
                HomeView()
                    .tabItem{
                        Label{
                            Text("Home")
                        } icon: {
                            Image("BARNHOUSE")
                        }
                    }
                
                CardsView()
                    .tabItem {
                        Label("All Cards", systemImage: "rectangle.on.rectangle.angled")
                    }
                
                DeckView()
                    .tabItem {
                        Label("Decks", systemImage: "rectangle.stack")
                    }
                
                TagsView()
                    .tabItem {
                        Label("Tags", systemImage: "tag")
                    }
                SettingsView()
                    .tabItem {
                        Label("Credits", systemImage: "list.clipboard")
                    }
//                CardDrawingView()
//                    .tabItem {
//                        Label("Drawing Tool", systemImage: "circle")
//                    }
            }
        }
        .onAppear {
            let descriptor = FetchDescriptor<Card>(predicate: #Predicate { $0.front.count > 0 })
            let count = (try? modelContext.fetchCount(descriptor)) ?? 0
            
            if count == 0 {
                let rome = Card(front: "ffff")
                let florence = Card(front: "ssss")
                let naples = Card(front: "nnnnnn")
                
                modelContext.insert(rome)
                modelContext.insert(florence)
                modelContext.insert(naples)
            }
        }
    }
    
    init() {
        let rome = Card(front: "test1")
        let florence = Card(front: "test2")
        let naples = Card(front: "test3")
        
        //modelContext.insert(rome)
        //modelContext.insert(florence)
        //modelContext.insert(naples)
    }
}

#Preview {
    ContentView()
}
