//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by yEETBOI on 6/11/24.
//test

import SwiftUI
import SwiftData

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
}

extension View {
    func title() -> some View {
        modifier(Title())
    }
}

extension View {
    func Exit() -> some View {
        Text("Drag here to exit view!")
            .padding()
    }
}

struct ContentView: View { // Homepage
    @State private var showCredits = false
    @State private var showingActionSheet = false
    
    var body: some View {
        NavigationView {
            TabView{
                HomeView()
                    .tabItem{
                        Label("Home", systemImage: "house.fill")
                    }
                CardsView(filter: .none)
                    .tabItem {
                        Label("All Cards", systemImage: "rectangle.on.rectangle.angled")
                    }
                
                CardsView(filter: .deck)
                    .tabItem {
                        Label("Decks", systemImage: "rectangle.stack")
                    }
                
                CardsView(filter: .tagged)
                    .tabItem {
                        Label("Tags", systemImage: "tag")
                    }
                SettingsView()
                    .tabItem {
                        Label("Credits", systemImage: "gearshape.fill")
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
