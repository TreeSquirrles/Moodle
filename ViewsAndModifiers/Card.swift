//
//  Card.swift
//  ViewsAndModifiers
//
//  Created by Seungyoo Kim-Jung on 7/4/24.
//

import Foundation
import SwiftData

@Model
class Card {
    @Attribute(.unique) var id: Int64
    var front: String
    var back: String
    var dateAdded: Date
    
    var tags = [Tag]()
    
    init(id: Int64 = Int64.random(in: -9223372036854775808...9223372036854775807), front: String = "Front", back: String = "Back", dateAdded: Date = .now) {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
        self.id = id
        self.front = front
        self.back = back
        self.dateAdded = dateAdded
        
        //self.tags = []
    }
}


@Model
class Tag {
    @Attribute(.unique) var tagName: String
    @Relationship(inverse: \Card.tags) var cards = [Card]()
    
    init(tagName: String) {
        self.tagName = tagName
        
        //cards = []
    }
}
