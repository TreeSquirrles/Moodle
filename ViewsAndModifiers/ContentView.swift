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
    @State private var showCredits = false
    @State private var showingActionSheet = false
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationView {
            TabView{
                HomeView()
                    .tabItem{
                        Label("Home", systemImage: "house.fill")
                    }
                
                CardsView()
                    .tabItem {
                        Label("All Cards", systemImage: "rectangle.on.rectangle.angled")
                    }
                
                DeckView()
                    .tabItem {
                        Label("Decks", systemImage: "rectangle.stack")
                    }
                
                TagsView(filter: .tagged)
                    .tabItem {
                        Label("Tags", systemImage: "tag")
                    }
                SettingsView()
                    .tabItem {
                        Label("Credits", systemImage: "gearshape.fill")
                    }
//                CardDrawingView()
//                    .tabItem {
//                        Label("Drawing Tool", systemImage: "circle")
//                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
