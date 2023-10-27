import SwiftUI

extension User {
    public var itemsArray: [Item] {
        let set = items as? Set<Item> ?? []
        return set.sorted { $0.price < $1.price }
    }
}

struct WardrobeView: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\Item.name)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var users: FetchedResults<User>
    
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack{
            VStack{
                Text("Wardrobe")
                    .padding(.top, 60)
                    .font(.cherryBombOne(.regular, size: 30))
            }
            
            Text("Itens que o usuário tem:")
                .font(.cherryBombOne(.regular, size: 16))
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(users) { user in
                    
                    ForEach(user.itemsArray) { item in
                        AccessoryComponent(item: item)
                    }
                    
                }
            }
            
            Text("Itens que o usuário não tem:")
                .font(.cherryBombOne(.regular, size: 16))
            LazyVGrid(columns: columns, spacing: 20) {
                
                ForEach(items) { item in
                    AccessoryComponent(item: item)
                        .opacity(0.5)
                }
            }
            
            Spacer()
        }
        .onAppear{
            if items.count == 0 {
                //Building the itens app
                DataController().addItem(name: "Óculos", photo: "WardrobeAccessory1", price: 20, type: "Acessorie", itemDescription: "Óculos vermelho", context: managedObjContext)
                DataController().addItem(name: "Boina", photo: "WardrobeAccessory2", price: 30, type: "Acessorie", itemDescription: "Boina vermelho", context: managedObjContext)
                DataController().addItem(name: "Cachecol", photo: "WardrobeAccessory3", price: 10, type: "Acessorie", itemDescription: "Cachecol colorido", context: managedObjContext)
                DataController().addItem(name: "Gravata", photo: "WardrobeAccessory4", price: 50, type: "Acessorie", itemDescription: "Gravata azul", context: managedObjContext)
                
                // Building user
                DataController().addUser(firstLogin: Date(), lastLogin: Date(), streak: 10, gems: 10, coins: 10, items: [], context: managedObjContext)
                
                if let user = users.first {
                    let items2 = user.mutableSetValue(forKey: "items")
                    items2.addObjects(from: [items[0], items[3]])
                    do {
                        try managedObjContext.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            
        }
    }
}

//#Preview {
//    WardrobeView()
//}
