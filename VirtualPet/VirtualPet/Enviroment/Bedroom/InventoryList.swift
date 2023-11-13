import SwiftUI

struct InventoryList: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    @State var isActive: Bool = false
    
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\Item.name)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var users: FetchedResults<User>
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    @State var itemPopUp: Item?
    
    var body: some View {
        VStack{
            VStack{
                HStack{
                    Circle()
                        .fill(.white)
                        .frame(width: 40)
                    Text("Collection")
                        .frame(alignment: .center)
                        .font(.fontStyle(.title))
                        .padding(.horizontal, 37)
                    Circle()
                        .fill(Color.brandIcons)
                        .frame(width: 40)
                }
                .padding(.top, 40)
            }
            .frame(width: 600, height: 184)
            .background(Rectangle().fill(Color.white))
            
            Spacer()
            ScrollView{
                VStack{
                    HStack{
                        PetListComponentBar(backgroudColor: .green, name: "Itens", quantity: "2/7")
                            .padding(.top, 20)
                            .padding(.horizontal, 20)
                    }
                    ZStack{
                        LazyVGrid(columns: columns) {
                            ForEach(users) { user in
                                ForEach(user.itemsArray) { item in
                                    InventoryListComponent(strokeColor: .pink, backgroudColor: Color.background, item: item)
                                        .onTapGesture {
                                            itemPopUp = item
                                            isActive = true
                                        }
                                }
                            }
                        }
                        if isActive {
                            PopUpAccessory(isActive: $isActive, item: itemPopUp!, user: users.first!, context: managedObjContext)
                        }
                    }
                }
            }
            TabbarView()
        }
        .background(Color.background)
    }
}
