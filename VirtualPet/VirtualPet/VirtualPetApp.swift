import SwiftUI

extension User {
    public var itemsArray: [Item] {
        let set = items as? Set<Item> ?? []
        return set.sorted { $0.price < $1.price }
    }
}

@main
struct VirtualPetApp: App {
    let dataController = DataController.shared
    
    var body: some Scene {
        WindowGroup {
            EggSelectionView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(Constants())
        }
    }
}

struct StartView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\Item.name)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var users: FetchedResults<User>
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var virtualPet: FetchedResults<VirtualPet>
    
    @EnvironmentObject var constants: Constants
    
    var body: some View {
        EggSelectionView(selectedEgg: false)
            .onAppear{
                if items.count == 0 {
                    //Building the wardrobe accessory app
                    DataController().addItem(name: "Óculos", photo: "WardrobeAccessory1", price: 20, type: "Acessorie", itemDescription: "Óculos vermelho", context: managedObjectContext, x: "10", y: "10")
                    DataController().addItem(name: "Boina", photo: "WardrobeAccessory2", price: 30, type: "Acessorie", itemDescription: "Boina vermelho", context: managedObjectContext, x: "10", y: "10")
                    DataController().addItem(name: "Cachecol", photo: "WardrobeAccessory3", price: 10, type: "Acessorie", itemDescription: "Cachecol colorido", context: managedObjectContext, x: "10", y: "10")
                    DataController().addItem(name: "Gravata", photo: "WardrobeAccessory4", price: 50, type: "Acessorie", itemDescription: "Gravata azul", context: managedObjectContext, x: "10", y: "10")
                    
                    //Building the fridge accessory app
                    DataController().addItem(name: "Óculos", photo: "FridgeAccessory1", price: 20, type: "Acessorie", itemDescription: "Óculos vermelho", context: managedObjectContext , x: "10", y: "10")
                    DataController().addItem(name: "Boina", photo: "FridgeAccessory2", price: 30, type: "Acessorie", itemDescription: "Boina vermelho", context: managedObjectContext, x: "10", y: "10")
                    DataController().addItem(name: "Cachecol", photo: "FridgeAccessory3", price: 10, type: "Acessorie", itemDescription: "Cachecol colorido", context: managedObjectContext, x: "10", y: "10")
                    DataController().addItem(name: "Gravata", photo: "FridgeAccessory4", price: 50, type: "Acessorie", itemDescription: "Gravata azul", context: managedObjectContext, x: "10", y: "10")
                    DataController().addItem(name: "Gravata", photo: "FridgeAccessory5", price: 50, type: "Acessorie", itemDescription: "Gravata azul", context: managedObjectContext, x: "10", y: "10")
                    
                    //Building virtual pets
                    DataController().addVirtualPet(name: "Pet1", birthday: nil, currentXP: 0, xpToEvolve: 0, friendship: 0, sleep: 0, hunger: 0, hygiene: 0, entertainmet: 0, steps: 0, index: 001, species: nil, isKnow: false, petDescription: "Pet1", photo: "Pet1", evolutionStage: nil, favoriteFood: nil, context: managedObjectContext)
                    DataController().addVirtualPet(name: "Pet2", birthday: nil, currentXP: 0, xpToEvolve: 0, friendship: 0, sleep: 0, hunger: 0, hygiene: 0, entertainmet: 0, steps: 0, index: 002, species: nil, isKnow: false, petDescription: "Pet2", photo: "Pet2", evolutionStage: nil, favoriteFood: nil, context: managedObjectContext)
                    DataController().addVirtualPet(name: "Pet3", birthday: nil, currentXP: 0, xpToEvolve: 0, friendship: 0, sleep: 0, hunger: 0, hygiene: 0, entertainmet: 0, steps: 0, index: 003, species: nil, isKnow: false, petDescription: "Pet3", photo: "Pet3", evolutionStage: nil, favoriteFood: nil, context: managedObjectContext)
                    
                    // Building user
                    DataController().addUser(firstLogin: Date(), lastLogin: Date(), streak: 10, gems: 10, coins: 10, items: [], currentBuddy: nil, context: managedObjectContext)
                    
                    if let user = users.first {
                        let its = user.mutableSetValue(forKey: "items")
                        let vp = user.mutableSetValue(forKey: "currentBuddy")
                        its.addObjects(from: [items[0], items[3]])
                        if virtualPet.count > 0 {
                            vp.addObjects(from: [virtualPet[0]])
                        }
                                                
                        do {
                            try managedObjectContext.save()
                        } catch {
                            print(error.localizedDescription)
                        }
                        
                        if let cb = user.getCurrentBuddy(){
                            constants.timerDecreaseEntertainment = Timer.scheduledTimer(withTimeInterval: TimeInterval(constants.timeToEntertainmentSec), repeats: cb.entertainmet > 0) { _ in
                                cb.entertainmet -= 1
                                do {
                                    try managedObjectContext.save()
                                } catch {
                                    print(error.localizedDescription)
                                }
                                constants.objectWillChange.send()
                            }
                            
                            constants.timerDecreaseHunger = Timer.scheduledTimer(withTimeInterval: TimeInterval(constants.timeToHungerSec), repeats: cb.hunger > 0) { _ in
                                cb.hunger -= 1
                                do {
                                    try managedObjectContext.save()
                                } catch {
                                    print(error.localizedDescription)
                                }
                                constants.objectWillChange.send()
                            }
                            
                            constants.timerDecreaseHygiene = Timer.scheduledTimer(withTimeInterval: TimeInterval(constants.timeToHygieneSec), repeats: cb.hygiene > 0) { _ in
                                cb.hygiene -= 1
                                do {
                                    try managedObjectContext.save()
                                } catch {
                                    print(error.localizedDescription)
                                }
                                constants.objectWillChange.send()
                            }
                            
                            constants.timerDecreaseSleep = Timer.scheduledTimer(withTimeInterval: TimeInterval(constants.timeToSleepSec), repeats: cb.sleep > 0) { _ in
                                cb.sleep -= 1
                                do {
                                    try managedObjectContext.save()
                                } catch {
                                    print(error.localizedDescription)
                                }
                                constants.objectWillChange.send()
                            }
                        }
                    }
                }
            }
    }
}
