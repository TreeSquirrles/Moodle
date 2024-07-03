//
//  Decks+CoreDataProperties.swift
//  ViewsAndModifiers
//
//  Created by Seungyoo Kim-Jung on 7/2/24.
//
//

import Foundation
import CoreData


extension Decks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Decks> {
        return NSFetchRequest<Decks>(entityName: "Decks")
    }

    @NSManaged public var deckName: String?
    @NSManaged public var card: NSSet?

    public var wrappedDeckName: String {
        deckName ?? "My Deck"
    }
    
    public var cardArray: [Cards] {
        let set = card as? Set<Cards> ?? []
        
        return set.sorted{
            $0.wrappedDateAdded < $1.wrappedDateAdded
        }
    }
}

// MARK: Generated accessors for card
extension Decks {

    @objc(addCardObject:)
    @NSManaged public func addToCard(_ value: Cards)

    @objc(removeCardObject:)
    @NSManaged public func removeFromCard(_ value: Cards)

    @objc(addCard:)
    @NSManaged public func addToCard(_ values: NSSet)

    @objc(removeCard:)
    @NSManaged public func removeFromCard(_ values: NSSet)

}

extension Decks : Identifiable {

}
