import Foundation
import SwiftUI
import CoreData

class DataController: ObservableObject {
    
    static let shared = DataController()

    let container = NSPersistentContainer(name: "VirtualPet")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print ("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print ("SALVO ITEM!!!")
        } catch {
            print("We couldn't save the data :(")
        }
    }
    
    func addItem (name: String, photo: String, price: Int32, type: String, itemDescription: String, context:NSManagedObjectContext) {
        
        let item = Item(context: context)
        
        item.id = UUID()
        item.name = name
        item.photo = photo
        item.price = price
        item.type = type
        item.itemDescription = itemDescription
        
        save(context: context)
    }
    
    func addUser(firstLogin: Date, lastLogin: Date, streak: Int32, gems: Int64, coins: Int64, items: NSSet, context: NSManagedObjectContext) {
        
        let user = User(context: context)
        
        user.id = UUID()
        user.firstLogin = firstLogin
        user.lastLogin = lastLogin
        user.streak = streak
        user.gems = gems
        user.coins = coins
        
        user.items = items
        
        save(context: context)
        
    }
    
    func deleteItem () {
        //complete
    }
    
}
