//
//  ViewsAndModifiersApp.swift
//  ViewsAndModifiers
//
//  Created by yEETBOI on 6/11/24.
//

import SwiftUI

@main
struct ViewsAndModifiersApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
