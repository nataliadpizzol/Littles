//
//  Lists+CoreDataProperties.swift
//  VirtualPet
//
//  Created by Sofia Sartori on 25/10/23.
//
//

import Foundation
import CoreData


extension Lists {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Lists> {
        return NSFetchRequest<Lists>(entityName: "Lists")
    }

    @NSManaged public var petsAll: NSOrderedSet?
    @NSManaged public var itemsAll: NSOrderedSet?

}

// MARK: Generated accessors for petsAll
extension Lists {

    @objc(insertObject:inPetsAllAtIndex:)
    @NSManaged public func insertIntoPetsAll(_ value: Pet, at idx: Int)

    @objc(removeObjectFromPetsAllAtIndex:)
    @NSManaged public func removeFromPetsAll(at idx: Int)

    @objc(insertPetsAll:atIndexes:)
    @NSManaged public func insertIntoPetsAll(_ values: [Pet], at indexes: NSIndexSet)

    @objc(removePetsAllAtIndexes:)
    @NSManaged public func removeFromPetsAll(at indexes: NSIndexSet)

    @objc(replaceObjectInPetsAllAtIndex:withObject:)
    @NSManaged public func replacePetsAll(at idx: Int, with value: Pet)

    @objc(replacePetsAllAtIndexes:withPetsAll:)
    @NSManaged public func replacePetsAll(at indexes: NSIndexSet, with values: [Pet])

    @objc(addPetsAllObject:)
    @NSManaged public func addToPetsAll(_ value: Pet)

    @objc(removePetsAllObject:)
    @NSManaged public func removeFromPetsAll(_ value: Pet)

    @objc(addPetsAll:)
    @NSManaged public func addToPetsAll(_ values: NSOrderedSet)

    @objc(removePetsAll:)
    @NSManaged public func removeFromPetsAll(_ values: NSOrderedSet)

}

// MARK: Generated accessors for itemsAll
extension Lists {

    @objc(insertObject:inItemsAllAtIndex:)
    @NSManaged public func insertIntoItemsAll(_ value: Item, at idx: Int)

    @objc(removeObjectFromItemsAllAtIndex:)
    @NSManaged public func removeFromItemsAll(at idx: Int)

    @objc(insertItemsAll:atIndexes:)
    @NSManaged public func insertIntoItemsAll(_ values: [Item], at indexes: NSIndexSet)

    @objc(removeItemsAllAtIndexes:)
    @NSManaged public func removeFromItemsAll(at indexes: NSIndexSet)

    @objc(replaceObjectInItemsAllAtIndex:withObject:)
    @NSManaged public func replaceItemsAll(at idx: Int, with value: Item)

    @objc(replaceItemsAllAtIndexes:withItemsAll:)
    @NSManaged public func replaceItemsAll(at indexes: NSIndexSet, with values: [Item])

    @objc(addItemsAllObject:)
    @NSManaged public func addToItemsAll(_ value: Item)

    @objc(removeItemsAllObject:)
    @NSManaged public func removeFromItemsAll(_ value: Item)

    @objc(addItemsAll:)
    @NSManaged public func addToItemsAll(_ values: NSOrderedSet)

    @objc(removeItemsAll:)
    @NSManaged public func removeFromItemsAll(_ values: NSOrderedSet)

}

extension Lists : Identifiable {

}
