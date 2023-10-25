//
//  Pet+CoreDataProperties.swift
//  VirtualPet
//
//  Created by Sofia Sartori on 24/10/23.
//
//

import Foundation
import CoreData


extension Pet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pet> {
        return NSFetchRequest<Pet>(entityName: "Pet")
    }

    @NSManaged public var index: Int32
    @NSManaged public var species: String?
    @NSManaged public var isKnown: Bool
    @NSManaged public var petDescription: String?
    @NSManaged public var photo: String?
    @NSManaged public var evolutionStage: String?

}

extension Pet : Identifiable {

}
