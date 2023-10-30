//
//  Item+CoreDataProperties.swift
//  VirtualPet
//
//  Created by Sofia Sartori on 24/10/23.
//
//

import Foundation
import CoreData

extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }
    
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var photo: String?
    @NSManaged public var price: Int32
    @NSManaged public var type: String?
    @NSManaged public var itemDescription: String?

}

extension Item : Identifiable {

}
