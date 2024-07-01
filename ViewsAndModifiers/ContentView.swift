//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by yEETBOI on 6/11/24.
//test

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

extension View {
    func button() -> some View {
        modifier(Buttonn())
    }
}

struct ContentView: View { // Homepage
    @State private var showCredits = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Image("Moodle")
                
                Text("MOODLE")
                    .font(.largeTitle)
                    .fontDesign(.rounded)
                    .fontWeight(.heavy)
                
                Spacer()
                
                Button("Cards") { }
                    .button()
                Button("Decks/Study") { }
                    .button()
                Button("Credits") {
                    showCredits = true
                }
                .button()
                
                Spacer()
                Spacer()
            }
            .padding().padding().padding().padding()
            .background(.quinary, ignoresSafeAreaEdges: .all)
            .sheet(isPresented: $showCredits) {
                Credits()
            }
        }
    }
}

struct Credits: View {
    var body: some View {
        VStack {
            Text("Drag here to exit view!")
                .padding()
            
            Spacer()
            Text("Hello!")
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
