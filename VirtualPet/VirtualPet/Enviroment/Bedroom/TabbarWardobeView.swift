import SwiftUI

struct TabbarWardobeView: View {
    
    var accessoryType: String
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    @Binding var itemName: String
    
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
        
    var body: some View {
        GeometryReader { reader in
            ZStack{
                VStack{
                    ScrollView{
                        LazyVGrid(columns: columns) {
                            ItemComponent(strokeColor: .white, backgroudColor: .yellow, item: nil)
                                .onTapGesture {
                                    itemName = "happy"
                                    DataController().changeAccessory(newAccessory: nil, user: users.first!, context: managedObjectContext)
                                }
                            
                            //ele ja tem
                            ForEach(users) { user in
                                ForEach(user.itemsArray) { item in
                                    if item.type == accessoryType {
                                        ItemComponent(strokeColor: .white, backgroudColor: .yellow, item: item, foodCount: .constant(0))
                                            .onTapGesture {
                                                DataController().changeAccessory(newAccessory: item, user: user, context: managedObjectContext)
                                                itemName = item.photo!
                                            }
                                    }
                                }
                            }
                            
                            ForEach(items) { item in
                                if !users[0].itemsArray.contains(item) {
                                    if item.type == accessoryType {
                                        ItemComponent(strokeColor: .white, backgroudColor: .yellow, item: item, foodCount: .constant(0))
                                            .opacity(0.6)
                                            .onTapGesture {
                                                constants.selectedItem = item
                                            }
                                    }
                                }
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

