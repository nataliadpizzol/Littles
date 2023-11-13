import SwiftUI

struct FridgeView: View {
    
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
                Text("Fridge")
                    .padding(.top, 60)
                    .font(.fontStyle(.title))
            }
            
            Text("Comidas que o usuário tem:")
                .font(.fontStyle(.body))
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(users) { user in
                    
                    ForEach(user.itemsArray) { item in
                        AccessoryComponent(item: item)
                    }
                }
            }
            
            Text("Comidas que o usuário não tem:")
                .font(.fontStyle(.body))
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
    FridgeView()
}
