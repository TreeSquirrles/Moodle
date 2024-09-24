//
//  Card.swift
//  ViewsAndModifiers
//
//  Created by Seungyoo Kim-Jung on 7/4/24.
//

import Foundation
import SwiftData


// Don't mind any of this, this was just to try and genericize the CardsView so that we didn't have to make another DecksView file.
//protocol Moodle {
//    associatedtype Element
//    
//    @Attribute(.unique) var id /* a unique id */ : UUID { get }
//    var front /* title */ : Element { get set }
//    var back /* Description */ : String { get set }
//    var dateAdded : Date { get }
//    
//}

//Moodle Protocol Wrapper
//struct AnyMoodle: Identifiable, Hashable {
//    let id: UUID
//    private let _getFront: () -> Any
//    private let _getBack: () -> String
//    private let _getDateAdded: () -> Date
//    private let _wrapped: Any
//    
//    var front: Any {
//        return _getFront()
//    }
//    
//    var back: String {
//        return _getBack()
//    }
//    
//    var dateAdded: Date {
//        return _getDateAdded()
//    }
//    
//    var wrapped: Any {
//        return _wrapped
//    }
//    
//    init<T: Moodle>(_ item: T) {
//        self.id = item.id
//        self._getFront = { item.front }
//        self._getBack = { item.back }
//        self._getDateAdded = { item.dateAdded }
//        self._wrapped = item
//    }
//    
//    static func == (lhs: AnyMoodle, rhs: AnyMoodle) -> Bool {
//        return lhs.id == rhs.id
//    }
//    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
//}


extension PersistentModel {
    func getPersistentModelID() -> PersistentIdentifier
    {
        self.persistentModelID
    }
}

// Danger!!! Don't give id a UUID type. for some reason it won't compile anymore
// Danger!!! @Model macro really hates this one trick: having your model conform to another protocol.
@Model
class Card: Hashable{
    @Attribute(.unique) var id: Int64
    var front: String
    var back: String
    var dateAdded: Date
    
    var tags = [Tag]()
    var deck: Deck?
    
    @Attribute(.externalStorage) var drawingFront: Data?
    @Attribute(.externalStorage) var drawingBack: Data?

    init(id: Int64 = Int64.random(in: Int64.min...Int64.max), front: String = "Front", back: String = "Back", deck: Deck? = nil, drawingFront: Data? = nil, drawingBack: Data? = nil) {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
        
        self.id = id
        self.front = front
        self.back = back
        self.dateAdded = Date.now
        self.deck = deck
        self.drawingFront = drawingFront
        self.drawingBack = drawingBack
        
        //self.tags = []
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(id)
    }
}
extension PersistentIdentifier {
    public func persistentModel<Model>(from context: ModelContext) -> Model? where Model : PersistentModel {
        return context.model(for: self) as? Model
    }
}

@Model
class Deck: Hashable {
    @Attribute(.unique) var id: Int64
    @Attribute(.unique) var name: String
    
    @Relationship(inverse: \Card.deck) var cards = [Card]()
    
    init(id:Int64 = Int64.random(in: Int64.min...Int64.max), name: String = "My Deck", cards: [Card] = [Card]()) {
        self.id = id
        self.name = name
        self.cards = cards
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(id)
    }
}


@Model
class Tag: Hashable {
    @Attribute(.unique) var tagName: String
    @Relationship(inverse: \Card.tags) var cards = [Card]()
    
    init(tagName: String = "My Tag") {
        self.tagName = tagName
        
        //cards = []
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(tagName)
    }
}
