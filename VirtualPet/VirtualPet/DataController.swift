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
    
    func addItem (name: String, photo: String, price: Int32, type: String, itemDescription: String, context:NSManagedObjectContext, x: String, y: String) {
        
        let item = Item(context: context)
        
        item.id = UUID()
        item.name = name
        item.photo = photo
        item.price = price
        item.type = type
        item.itemDescription = itemDescription
        item.positionX = x
        item.positionY = y
        
        save(context: context)
    }
    
    func addUser(firstLogin: Date, lastLogin: Date, streak: Int32, gems: Int64, coins: Int64, items: NSSet, currentBuddy: NSSet?, context: NSManagedObjectContext) {
        
        let user = User(context: context)
        
        user.id = UUID()
        user.firstLogin = firstLogin
        user.lastLogin = lastLogin
        user.streak = streak
        user.gems = gems
        user.coins = coins
        user.items = items
        user.currentBuddy = currentBuddy
        
        save(context: context)
        
    }
    
    func addPet(index: Int32, species: String?, isKnown: Bool, petDescription: String?, photo: String?, evolutionStage: String?, context: NSManagedObjectContext) {
        let pet = Pet(context: context)
        
        pet.index = index
        pet.species = species
        pet.isKnown = isKnown
        pet.petDescription = petDescription
        pet.photo = photo
        pet.evolutionStage = evolutionStage
        
        save(context: context)
    }
    
    func addVirtualPet(name: String?, birthday: Date?, currentXP: Int32, xpToEvolve: Int32, level: Int32, friendship: Int32, sleep: Int32, hunger: Int32, hygiene: Int32, entertainmet: Int32, steps: Int32, index: Int32, species: String?, isKnow: Bool, petDescription: String?, photo: String?, evolutionStage: String?, favoriteFood: Item?, context: NSManagedObjectContext) {
        let pet = VirtualPet(context: context)
        
        pet.name = name
        pet.birthday = birthday
        pet.currentXP = currentXP
        pet.xpToEvolve = xpToEvolve
        pet.level = level
        pet.friendship = friendship
        pet.sleep = sleep
        pet.hunger = hunger
        pet.hygiene = hygiene
        pet.entertainmet = entertainmet
        pet.steps = steps
        pet.index = index
        pet.species = species
        pet.isKnow = isKnow
        pet.petDescription = petDescription
        pet.photo = photo
        pet.evolutionStage = evolutionStage
        pet.favoriteFood = favoriteFood
        
        save(context: context)
    }
    
    func deleteItem () {
        //complete
    }
    
    public func changeAccessory(newAccessory: Item, user: User, context: NSManagedObjectContext) {
        let currentBuddy = user.getCurrentBuddy()
        currentBuddy?.currentAccessoryImageName = newAccessory.photo
        currentBuddy?.accessoryPositionX = newAccessory.positionX
        currentBuddy?.accessoryPositionY = newAccessory.positionY
        
        save(context: context)
        
    }
    
    
}
