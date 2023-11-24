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
    
    var itemType: ItemType = .glasses
    
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
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            }
        }
        .onAppear{
            if constants.music {
                constants.playAudio(audio: "backgroundSound")
            }
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
                //Glasses
                
                #warning("ItemType.glasses")
                
                DataController().addItem(name: "3d", photo: "WardrobeAccessory3d", price: 23, type: "glasses", itemDescription: "Glass 3d", context: managedObjectContext, x: "150", y: "15")
                DataController().addItem(name: "Cat eye glasses", photo: "WardrobeAccessoryCat", price: 30, type: "glasses", itemDescription: "Cat eye glasses", context: managedObjectContext, x: "150", y: "10")
                DataController().addItem(name: "Heart", photo: "WardrobeAccessoryHeart", price: 26, type: "glasses", itemDescription: "Heart glasses", context: managedObjectContext, x: "150", y: "10")
                DataController().addItem(name: "Gravata", photo: "WardrobeAccessoryJohnLennon", price: 50, type: "glasses", itemDescription: "John Lennon glasses", context: managedObjectContext, x: "150", y: "10")
                DataController().addItem(name: "Ninja", photo: "WardrobeAccessoryNinja", price: 22, type: "glasses", itemDescription: "Ninja glasses", context: managedObjectContext, x: "150", y: "10")
                DataController().addItem(name: "Ninja", photo: "WardrobeAccessorySquare", price: 20, type: "glasses", itemDescription: "Square glasses", context: managedObjectContext, x: "150", y: "10")
                
                //Hand/Body
                DataController().addItem(name: "Blanket", photo: "WardrobeAccessoryBlanket", price: 30, type: "handBody", itemDescription: "Blanket", context: managedObjectContext, x: "150", y: "10")
                DataController().addItem(name: "Guitar", photo: "WardrobeAccessoryGuitar", price: 50, type: "handBody", itemDescription: "Guitar", context: managedObjectContext, x: "150", y: "10")
                DataController().addItem(name: "IceCream", photo: "WardrobeAccessoryBlanket", price: 50, type: "handBody", itemDescription: "IceCream", context: managedObjectContext, x: "150", y: "10")
                DataController().addItem(name: "Iphone", photo: "WardrobeAccessoryIphone", price: 28, type: "handBody", itemDescription: "Iphone", context: managedObjectContext, x: "150", y: "10")
                DataController().addItem(name: "Wand", photo: "WardrobeAccessoryWand", price: 40, type: "handBody", itemDescription: "Wand", context: managedObjectContext, x: "150", y: "10")
                DataController().addItem(name: "MagnifyingGlass", photo: "WardrobeAccessoryMagnifyingGlass", price: 20, type: "handBody", itemDescription: "MagnifyingGlass", context: managedObjectContext, x: "150", y: "10")
                
                //Hats
                DataController().addItem(name: "Cowboy", photo: "WardrobeAccessoryCowboy", price: 45, type: "hat", itemDescription: "Cowboy", context: managedObjectContext, x: "150", y: "10")
                DataController().addItem(name: "Duck", photo: "WardrobeAccessoryDuck", price: 60, type: "hat", itemDescription: "Duck", context: managedObjectContext, x: "150", y: "10")
                DataController().addItem(name: "LittleBoat", photo: "WardrobeAccessoryLittleBoat", price: 60, type: "hat", itemDescription: "LittleBoat", context: managedObjectContext, x: "150", y: "10")
                DataController().addItem(name: "Party", photo: "WardrobeAccessoryParty", price: 33, type: "hat", itemDescription: "Party", context: managedObjectContext, x: "150", y: "10")
                DataController().addItem(name: "Propeller", photo: "WardrobeAccessoryPropeller", price: 28, type: "hat", itemDescription: "Propeller", context: managedObjectContext, x: "150", y: "10")
                DataController().addItem(name: "TopHat", photo: "WardrobeAccessoryTopHat", price: 40, type: "hat", itemDescription: "TopHat", context: managedObjectContext, x: "150", y: "10")
                
                //Building the fridge accessory app
                DataController().addItem(name: "Apple", photo: "FridgeAccessoryApple", price: 20, type: "food", itemDescription: "Apple", context: managedObjectContext , x: "10", y: "10")
                DataController().addItem(name: "Banana", photo: "FridgeAccessoryBanana", price: 30, type: "food", itemDescription: "Banana", context: managedObjectContext, x: "10", y: "10")
                DataController().addItem(name: "Pizza", photo: "FridgeAccessoryPizza", price: 10, type: "food", itemDescription: "Pizza", context: managedObjectContext, x: "10", y: "10")
                DataController().addItem(name: "Sushi", photo: "FridgeAccessorySushi", price: 50, type: "food", itemDescription: "Sushi", context: managedObjectContext, x: "10", y: "10")
                DataController().addItem(name: "Tomate", photo: "FridgeAccessoryTomate", price: 50, type: "food", itemDescription: "Tomate", context: managedObjectContext, x: "10", y: "10")
                
                
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
