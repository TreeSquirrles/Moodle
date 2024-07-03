//
//  Tags+CoreDataProperties.swift
//  ViewsAndModifiers
//
//  Created by Seungyoo Kim-Jung on 7/2/24.
//
//

import Foundation
import CoreData


extension Tags {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tags> {
        return NSFetchRequest<Tags>(entityName: "Tags")
    }

    @NSManaged public var tagName: String?
    @NSManaged public var card: NSSet?

    public var wrappedTagName: String {
        tagName ?? "MyTag"
    }
    
    public var cardArray: [Cards] {
        let set = card as? Set<Cards> ?? []
        
        return set.sorted{
            $0.wrappedDateAdded < $1.wrappedDateAdded
        }
    }
}

// MARK: Generated accessors for card
extension Tags {

    @objc(addCardObject:)
    @NSManaged public func addToCard(_ value: Cards)

    @objc(removeCardObject:)
    @NSManaged public func removeFromCard(_ value: Cards)

    @objc(addCard:)
    @NSManaged public func addToCard(_ values: NSSet)

    @objc(removeCard:)
    @NSManaged public func removeFromCard(_ values: NSSet)

}

extension Tags : Identifiable {

}
