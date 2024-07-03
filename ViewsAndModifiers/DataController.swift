//
//  DataController.swift
//  ViewsAndModifiers
//
//  Created by Seungyoo Kim-Jung on 7/2/24.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "CardDB")
    
    init() {
        container.loadPersistentStores { descriptoin, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
