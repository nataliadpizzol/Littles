//
//  VirtualPet+CoreDataProperties.swift
//  VirtualPet
//
//  Created by Sofia Sartori on 24/10/23.
//
//

import Foundation
import CoreData


extension VirtualPet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<VirtualPet> {
        return NSFetchRequest<VirtualPet>(entityName: "VirtualPet")
    }

    @NSManaged public var name: String?
    @NSManaged public var birthday: Date?
    @NSManaged public var currentXP: Int32
    @NSManaged public var xpToEvolve: Int32
    @NSManaged public var friendship: Int32
    @NSManaged public var sleep: Int32
    @NSManaged public var hunger: Int32
    @NSManaged public var hygiene: Int32
    @NSManaged public var entertainmet: Int32
    @NSManaged public var steps: Int32
    @NSManaged public var index: Int32
    @NSManaged public var species: String?
    @NSManaged public var isKnow: Bool
    @NSManaged public var petDescription: String?
    @NSManaged public var photo: String?
    @NSManaged public var evolutionStage: String?
    @NSManaged public var favoriteFood: Item?

}

extension VirtualPet : Identifiable {

}
