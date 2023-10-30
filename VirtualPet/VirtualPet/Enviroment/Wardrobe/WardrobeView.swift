import SwiftUI

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
                    if !users[0].itemsArray.contains(item) {
                        AccessoryComponent(item: item)
                            .opacity(0.5)
                    }
                }
            }
            Spacer()
        }
    }
}

#Preview {
    WardrobeView()
}
