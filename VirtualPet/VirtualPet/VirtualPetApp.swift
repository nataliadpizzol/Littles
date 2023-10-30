import SwiftUI

extension User {
    public var itemsArray: [Item] {
        let set = items as? Set<Item> ?? []
        return set.sorted { $0.price < $1.price }
    }
}

@main
struct VirtualPetApp: App {
    
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\Item.name)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var users: FetchedResults<User>
    
    let dataController = DataController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(EnviromentTabView())
                .environmentObject(Constants())
                .onAppear{
                    if items.count == 0 {
                        //Building the wardrobe accessory app
                        DataController().addItem(name: "Óculos", photo: "WardrobeAccessory1", price: 20, type: "Acessorie", itemDescription: "Óculos vermelho", context: dataController.container.viewContext)
                        DataController().addItem(name: "Boina", photo: "WardrobeAccessory2", price: 30, type: "Acessorie", itemDescription: "Boina vermelho", context: dataController.container.viewContext)
                        DataController().addItem(name: "Cachecol", photo: "WardrobeAccessory3", price: 10, type: "Acessorie", itemDescription: "Cachecol colorido", context: dataController.container.viewContext)
                        DataController().addItem(name: "Gravata", photo: "WardrobeAccessory4", price: 50, type: "Acessorie", itemDescription: "Gravata azul", context: dataController.container.viewContext)
                        
                        //Building the fridge accessory app
                        DataController().addItem(name: "Óculos", photo: "FridgeAccessory1", price: 20, type: "Acessorie", itemDescription: "Óculos vermelho", context: dataController.container.viewContext)
                        DataController().addItem(name: "Boina", photo: "FridgeAccessory2", price: 30, type: "Acessorie", itemDescription: "Boina vermelho", context: dataController.container.viewContext)
                        DataController().addItem(name: "Cachecol", photo: "FridgeAccessory3", price: 10, type: "Acessorie", itemDescription: "Cachecol colorido", context: dataController.container.viewContext)
                        DataController().addItem(name: "Gravata", photo: "FridgeAccessory4", price: 50, type: "Acessorie", itemDescription: "Gravata azul", context: dataController.container.viewContext)
                        DataController().addItem(name: "Gravata", photo: "FridgeAccessory5", price: 50, type: "Acessorie", itemDescription: "Gravata azul", context: dataController.container.viewContext)
                        
                        // Building user
                        DataController().addUser(firstLogin: Date(), lastLogin: Date(), streak: 10, gems: 10, coins: 10, items: [], currentBuddy: nil, context: dataController.container.viewContext)
                        
                        if let user = users.first {
                            let items1 = user.mutableSetValue(forKey: "items")
                            items1.addObjects(from: [items[0], items[3]])
                            do {
                                try dataController.container.viewContext.save()
                            } catch {
                                print(error.localizedDescription)
                            }
                            
                        }
                        
                    }
                }
        }
    }
}
