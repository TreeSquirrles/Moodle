//
//  Cards+CoreDataProperties.swift
//  ViewsAndModifiers
//
//  Created by Seungyoo Kim-Jung on 7/2/24.
//
//

import Foundation
import CoreData


extension Cards {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cards> {
        return NSFetchRequest<Cards>(entityName: "Cards")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var front: String?
    @NSManaged public var back: String?
    @NSManaged public var dateAdded: Date?
    @NSManaged public var deck: Decks?
    @NSManaged public var level: Levels?
    @NSManaged public var tag: NSSet?

    public var wrappedFront: String {
        front ?? "No Front"
    }
    
    public var wrappedBack: String {
        back ?? "No Back"
    }
    
    public var wrappedDateAdded: Date {
        dateAdded ?? .now
    }
    
    public var tagsArray: [Tags] {
        let set = tag as? Set<Tags> ?? []
        
        return set.sorted{
            $0.wrappedTagName < $1.wrappedTagName
        }
    }
}

// MARK: Generated accessors for deck
extension Cards {

    @objc(addDeckObject:)
    @NSManaged public func addToDeck(_ value: Decks)

    @objc(removeDeckObject:)
    @NSManaged public func removeFromDeck(_ value: Decks)

    @objc(addDeck:)
    @NSManaged public func addToDeck(_ values: NSSet)

    @objc(removeDeck:)
    @NSManaged public func removeFromDeck(_ values: NSSet)

}

// MARK: Generated accessors for tag
extension Cards {

    @objc(addTagObject:)
    @NSManaged public func addToTag(_ value: Tags)

    @objc(removeTagObject:)
    @NSManaged public func removeFromTag(_ value: Tags)

    @objc(addTag:)
    @NSManaged public func addToTag(_ values: NSSet)

    @objc(removeTag:)
    @NSManaged public func removeFromTag(_ values: NSSet)

}

extension Cards : Identifiable {

}
