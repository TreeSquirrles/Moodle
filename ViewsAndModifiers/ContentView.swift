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
    @State private var showCards = false
    @State private var showCredits = false
    @State private var showingActionSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Image("Moodle")
                
                Text("MOODLE")
                    .title()
                
                Spacer()
                
                Button("Cards") {
                    showCards = true
                }
                    .button()
                Button("Decks/Study") {
                    // more code to come
                }
                    .button()
                Button("Credits") {
                    showCredits = true
                }
                .button()
                
                Button("Action Sheet") {
                    showingActionSheet = true
                }
                .button()
                
                Spacer()
                Spacer()
            }
            .padding().padding().padding().padding()
            .background(.quinary, ignoresSafeAreaEdges: .all)
            .sheet(isPresented: $showCards) {
                Cards()
            }
            .sheet(isPresented: $showCredits) {
                Credits()
            }
            .actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(title: Text("Change background"), message: Text("Select a new color"), buttons: [
                    .default(Text("Red")) {  },
                    .default(Text("Green")) {  },
                    .default(Text("Blue")) {  },
                    .cancel()
                ])
            }
        }
    }
}

struct Cards: View {
    @State private var cardNames = ["Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name", "Card Name"]
    
    @State private var deckCardisIn = ["Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck", "Card Deck"]
    
    @State private var cardTags = ["Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags", "Card Tags"]
    
    @State private var cards = 10
    
    var body: some View {
        NavigationStack{
            HStack{
                Button() {
                    //
                } label: {
                    Image(systemName: "folder.circle")
                }
                
                Exit()
                
                Menu() {
                    Button("Table") {
                        //
                    }
                    Button("List") {
                        //
                    }
                    Button("Sides") {
                        //
                    }
                } label: {
                    Image(systemName: "gearshape.fill")
                }
            }
            
            List{
                Section{
                    ForEach(0..<cards) {number in
                        HStack{
                            Text(cardNames[number])
                            Text(deckCardisIn[number])
                            Text(cardTags[number])
                        }
                    }
                }
            }
        }
    }
}

struct Credits: View {
    var body: some View {
        NavigationStack{
            VStack {
                Exit()
                
                Text("CREDITS")
                    .title()
                    .padding()
                
                
                Image("MoodleCircle")
                    .imageScale(.small)
                
                HStack{
                    VStack{
                        Text("About us")
                            .font(.title)
                            .fontDesign(.rounded)
                            .fontWeight(.heavy)
                        Text("This is one paragraph that I wrote by myself. It has nothing to do with what Moodle is about but it is a paragraph so it is okay. This paragraph will be replaced by a real one once we know what to write. This will be repeated on the other side.")
                            .padding([.top, .bottom], 0.4)
                        Text("This is the second paragraph we will use. It will help us to write a bunch of stuff with really nice spacing and all that good stuff. It will make everything look really good and that is what we want. Moodle needs to look good, after all.")
                            .padding([.top, .bottom], 0.4)
                        Text("Don't worry, we'll have many subtitles for all the other people around. It'll be really cool. :)")
                            .padding([.top], 0.4)
                    }
                    VStack{
                        Image("Divider")
                    }
                    VStack{
                        Text("Our mission")
                            .font(.title)
                            .fontDesign(.rounded)
                            .fontWeight(.heavy)
                        Text("\nThis is one paragraph that I wrote by myself. It has nothing to do with what Moodle is about but it is a paragraph so it is okay. This paragraph will be replaced by a real one once we know what to write. This will be repeated on the other side.\n\n")
                            .padding([.top, .bottom], 0.4)
                        Text("This is the second paragraph we will use. It will help us to write a bunch of stuff with really nice spacing and all that good stuff. It will make everything look really good and that is what we want. Moodle needs to look good, after all.\n\n")
                            .padding([.top, .bottom], 0.4)
                        Text("Don't worry, we'll have many subtitles for all the other people around. It'll be really cool. :)")
                            .padding([.top], 0.4)
                    }
                }
                .padding()
                
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}
