//
//  ViewsAndModifiersApp.swift
//  ViewsAndModifiers
//
//  Created by yEETBOI on 6/11/24.
//

import SwiftUI
import SwiftData

@main
struct ViewsAndModifiersApp: App {
    let modelContainer : ModelContainer
    //@Environment(\.modelContext) var modelContext
    
    init() {
        do {
            modelContainer = try ModelContainer(for: Card.self)
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
        
    }
    
    var body: some Scene {
        WindowGroup {
            VStack{
                ContentView()
            }
        }
        .modelContainer(for: Card.self)
        
    }
    
}
