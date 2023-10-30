//
//  User+CoreDataProperties.swift
//  VirtualPet
//
//  Created by Sofia Sartori on 24/10/23.
//
//

import Foundation
import CoreData

extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var firstLogin: Date?
    @NSManaged public var lastLogin: Date?
    @NSManaged public var streak: Int32
    @NSManaged public var gems: Int64
    @NSManaged public var coins: Int64
    @NSManaged public var currentBuddy: VirtualPet?
    @NSManaged public var pets: NSOrderedSet?
    @NSManaged public var items: NSSet?

}

// MARK: Generated accessors for pets
extension User {

    @objc(insertObject:inPetsAtIndex:)
    @NSManaged public func insertIntoPets(_ value: VirtualPet, at idx: Int)

    @objc(removeObjectFromPetsAtIndex:)
    @NSManaged public func removeFromPets(at idx: Int)

    @objc(insertPets:atIndexes:)
    @NSManaged public func insertIntoPets(_ values: [VirtualPet], at indexes: NSIndexSet)

    @objc(removePetsAtIndexes:)
    @NSManaged public func removeFromPets(at indexes: NSIndexSet)

    @objc(replaceObjectInPetsAtIndex:withObject:)
    @NSManaged public func replacePets(at idx: Int, with value: VirtualPet)

    @objc(replacePetsAtIndexes:withPets:)
    @NSManaged public func replacePets(at indexes: NSIndexSet, with values: [VirtualPet])

    @objc(addPetsObject:)
    @NSManaged public func addToPets(_ value: VirtualPet)

    @objc(removePetsObject:)
    @NSManaged public func removeFromPets(_ value: VirtualPet)

    @objc(addPets:)
    @NSManaged public func addToPets(_ values: NSOrderedSet)

    @objc(removePets:)
    @NSManaged public func removeFromPets(_ values: NSOrderedSet)

}

// MARK: Generated accessors for items
extension User {

    @objc(insertObject:inItemsAtIndex:)
    @NSManaged public func insertIntoItems(_ value: Item, at idx: Int)

    @objc(removeObjectFromItemsAtIndex:)
    @NSManaged public func removeFromItems(at idx: Int)

    @objc(insertItems:atIndexes:)
    @NSManaged public func insertIntoItems(_ values: [Item], at indexes: NSIndexSet)

    @objc(removeItemsAtIndexes:)
    @NSManaged public func removeFromItems(at indexes: NSIndexSet)

    @objc(replaceObjectInItemsAtIndex:withObject:)
    @NSManaged public func replaceItems(at idx: Int, with value: Item)

    @objc(replaceItemsAtIndexes:withItems:)
    @NSManaged public func replaceItems(at indexes: NSIndexSet, with values: [Item])

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: Item)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: Item)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSOrderedSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSOrderedSet)

}

extension User : Identifiable {
    func getProgress(enviroment: Enviroment) -> Int {
        switch enviroment {
        case .mainroom:
            return Int(currentBuddy!.entertainmet)
        case .kitchen:
            return Int(currentBuddy!.hunger)
        case .bathroom:
            return Int(currentBuddy!.hygiene)
        case .bedroom:
            return Int(currentBuddy!.sleep)
        case .garden:
            return 100
        }
    }
}
