import SwiftUI

extension User {
    public var itemsArray: [Item] {
        let set = items as? Set<Item> ?? []
        return set.sorted { $0.price < $1.price }
    }
}

extension User {
    public var petsArray: [Pet] {
        let set = pets as? Set<Pet> ?? []
        return set.sorted { $0.index < $1.index }
    }
}

@main
struct VirtualPetApp: App {
    let dataController = DataController.shared
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        WindowGroup {
            StartView()
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
    @State var firstTimeHere: Bool = UserDefaults.standard.value(forKey: "firstTimeHere") as? Bool ?? true
    @State private var isActive = false
    
    //var to control the presentention state of the onboarding
    @State var isPresenting = true
    
    var body: some View {
        ZStack {
            if self.isActive {
                if firstTimeHere {
                    ContentView()
                        //fullScreen modal to be dismissed once the onboarding is finished so we dont have navigation issues
                        .fullScreenCover(isPresented: $isPresenting) {
                            EggSelectionView(selectedEgg: false, showOnboarding: $isPresenting)
                        }
                    
                } else {
                    ContentView()
                }
                
            } else {
                Preview()
            }
        }
        .onAppear{
            // Preview time
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation {
                    self.isActive = true
                }
            }
            print("itens totais:", items.count)
            print("usuarios totais:", users.count)
            print("pets totais:", users.first?.getCurrentBuddy()?.name ?? "")

            if items.count == 0 {
                //Building the wardrobe accessory app
                DataController().addItem(name: "Boina", photo: "WardrobeAccessory1", price: 20, type: "Acessorie", itemDescription: "Boina", context: managedObjectContext, x: "150", y: "15")
                DataController().addItem(name: "Óculos", photo: "WardrobeAccessory2", price: 30, type: "Acessorie", itemDescription: "Óculos", context: managedObjectContext, x: "150", y: "10")
                DataController().addItem(name: "Cachecol", photo: "WardrobeAccessory3", price: 10, type: "Acessorie", itemDescription: "Cachecol", context: managedObjectContext, x: "150", y: "10")
                DataController().addItem(name: "Gravata", photo: "WardrobeAccessory4", price: 50, type: "Acessorie", itemDescription: "Gravata", context: managedObjectContext, x: "150", y: "10")
                
                //Building the fridge accessory app
                DataController().addItem(name: "Pizza", photo: "FridgeAccessory1", price: 20, type: "Food", itemDescription: "Pizza", context: managedObjectContext , x: "10", y: "10")
                DataController().addItem(name: "CupCake", photo: "FridgeAccessory2", price: 30, type: "Food", itemDescription: "CupCake", context: managedObjectContext, x: "10", y: "10")
                DataController().addItem(name: "Brócolis", photo: "FridgeAccessory3", price: 10, type: "Food", itemDescription: "Brócolis", context: managedObjectContext, x: "10", y: "10")
                DataController().addItem(name: "Pirulito", photo: "FridgeAccessory4", price: 50, type: "Food", itemDescription: "Pirulito", context: managedObjectContext, x: "10", y: "10")
                DataController().addItem(name: "Maça", photo: "FridgeAccessory5", price: 50, type: "Food", itemDescription: "Maça", context: managedObjectContext, x: "10", y: "10")
                
                
                //Building virtual pets
                DataController().addVirtualPet(name: "Pet1", birthday: nil, currentXP: 0, xpToEvolve: 0, level: 1, friendship: 0, sleep: 30, hunger: 30, hygiene: 30, entertainmet: 30, steps: 0, index: 001, species: nil, isKnow: false, petDescription: "Pet1", photo: "Pet1", evolutionStage: nil, favoriteFood: nil, context: managedObjectContext)
                DataController().addVirtualPet(name: "Pet2", birthday: nil, currentXP: 0, xpToEvolve: 0, level: 1, friendship: 0, sleep: 0, hunger: 0, hygiene: 0, entertainmet: 0, steps: 0, index: 002, species: nil, isKnow: false, petDescription: "Pet2", photo: "Pet2", evolutionStage: nil, favoriteFood: nil, context: managedObjectContext)
                DataController().addVirtualPet(name: "Pet3", birthday: nil, currentXP: 0, xpToEvolve: 0, level: 1, friendship: 0, sleep: 0, hunger: 0, hygiene: 0, entertainmet: 0, steps: 0, index: 003, species: nil, isKnow: false, petDescription: "Pet3", photo: "Pet3", evolutionStage: nil, favoriteFood: nil, context: managedObjectContext)
                
                // Building user
                DataController().addUser(firstLogin: Date(), lastLogin: Date(), streak: 10, gems: 10, coins: 34, items: [], currentBuddy: nil, context: managedObjectContext)
                
                if let user = users.first {
                    let its = user.mutableSetValue(forKey: "items")
                    its.addObjects(from: [items[0], items[3]])
                    if virtualPet.count > 0 {
                        user.currentBuddy = virtualPet[0]
                    }
                    
                    do {
                        try managedObjectContext.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}
