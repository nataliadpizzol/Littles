import SwiftUI

struct TabbarWardobeView: View {
    
    var accessoryType: String
    
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var vm = MainroomViewModel()
    @EnvironmentObject var constants: Constants
    
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\Item.name)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var users: FetchedResults<User>
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    @State var itemPopUp: Item?
    
    var body: some View {
        VStack{
            ScrollView{
                LazyVGrid(columns: columns) {
                    
                    //ITENS QUE ELE TEM
                    ForEach(users) { user in
                        ForEach(user.itemsArray) { item in
                            
                            // fazer puxar so os de um tipo do enum aqui
                            if item.type == accessoryType {
                                ItemComponent(strokeColor: .white, backgroudColor: .yellow, item: item)
                                    .onTapGesture {
                                        itemPopUp = item
                                    }
                            }
                        }
                    }
                    
                    //ITENS QUE ELE NAO TEM
                    ForEach(items) { item in
                        if !users[0].itemsArray.contains(item) {
                            if item.type == accessoryType {
                                ItemComponent(strokeColor: .white, backgroudColor: .yellow, item: item)
                                    .opacity(0.6)
                            }
                        }
                    }
                }
            }
            
        }
    }
}
//
//#Preview {
//    TabbarWardobeView()
//}

