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
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Card.self)
    }
}
