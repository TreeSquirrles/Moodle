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
    @Attribute(.unique) var id: UUID
    var front: String
    var back: String
    var dateAdded: Date
    
    var tags: [Tag]
    
    init(id: UUID, front: String, back: String, dateAdded: Date) {
        self.id = id
        self.front = front
        self.back = back
        self.dateAdded = dateAdded
        
        tags = []
    }
}

@Model
class Tag {
    @Attribute(.unique) var tagName: String
    @Relationship(inverse: \Card.tags) var cards: [Card]
    
    init(tagName: String) {
        self.tagName = tagName
        
        cards = []
    }
}
