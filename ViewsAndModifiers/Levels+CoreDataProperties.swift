//
//  Levels+CoreDataProperties.swift
//  ViewsAndModifiers
//
//  Created by Seungyoo Kim-Jung on 7/2/24.
//
//

import Foundation
import CoreData


extension Levels {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Levels> {
        return NSFetchRequest<Levels>(entityName: "Levels")
    }

    @NSManaged public var level: String?
    @NSManaged public var card: NSSet?

    public var wrappedLevel: String {
        level ?? "super difficult"
    }
    
    public var cardArray: [Cards] {
        let set = card as? Set<Cards> ?? []
        
        return set.sorted{
            $0.wrappedDateAdded < $1.wrappedDateAdded
        }
    }
}

// MARK: Generated accessors for card
extension Levels {

    @objc(addCardObject:)
    @NSManaged public func addToCard(_ value: Cards)

    @objc(removeCardObject:)
    @NSManaged public func removeFromCard(_ value: Cards)

    @objc(addCard:)
    @NSManaged public func addToCard(_ values: NSSet)

    @objc(removeCard:)
    @NSManaged public func removeFromCard(_ values: NSSet)

}

extension Levels : Identifiable {

}
