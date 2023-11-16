import SwiftUI

struct InventoryList: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    @State var isActive: Bool = false
    
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
            
            VStack{
                if constants.badroomLightIsOn {
                    ZStack {
                        Image(users.first?.getCurrentBuddy()?.sleep ?? 0 > 70 ? "Pet1-happy" : "Pet1-sad")
                            .resizable()
                            .frame(width: 270, height: 346)
                        if let accessoryImage = users.first?.getCurrentBuddy()?.currentAccessoryImageName {
                            
                            Image(accessoryImage)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .position(x: vm.getCGfloat(string: users.first?.getCurrentBuddy()?.accessoryPositionX), y: vm.getCGfloat(string: users.first?.getCurrentBuddy()?.accessoryPositionY))
                                .onAppear{
                                    print("tem acessorio")
                                }
                        }
                    }
                    .padding(.top, 30)
                }
                else {
                    ZStack {
                        Image(users.first?.getCurrentBuddy()?.sleep ?? 0 > 70 ? "Pet1-happy" : "Pet1-sad")
                            .resizable()
                            .frame(width: 270, height: 346)
                        if let accessoryImage = users.first?.getCurrentBuddy()?.currentAccessoryImageName {
                            
                            Image(accessoryImage)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .position(x: vm.getCGfloat(string: users.first?.getCurrentBuddy()?.accessoryPositionX), y: vm.getCGfloat(string: users.first?.getCurrentBuddy()?.accessoryPositionY))
                                .onAppear{
                                    print("tem acessorio")
                                }
                        }
                    }
                    .hidden()
                    .padding(.top, 160)
                }
                
                Rectangle()
                    .fill(.brandPurple2)
                    .frame(width: .infinity, height: 60)
                
                VStack{
                    ScrollView{
                        LazyVGrid(columns: columns) {
                            ForEach(users) { user in
                                ForEach(user.itemsArray) { item in
                                    ItemComponent(strokeColor: .white, backgroudColor: .yellow, item: item)
                                        .onTapGesture {
                                            itemPopUp = item
                                            isActive = true
                                        }
                                }
                            }
                            ForEach(items) { item in
                                if !users[0].itemsArray.contains(item) {
                                    ItemComponent(strokeColor: .white, backgroudColor: .yellow, item: item)
                                        .opacity(0.3)
                                }
                            }
                        }
                        if isActive {
                            PopUpAccessory(isActive: $isActive, item: itemPopUp!, user: users.first!, context: managedObjContext)
                        }
                    }
                }
                .brightness(constants.badroomLightIsOn ? 0 : 0.5)
                .padding(.top, 20)
                .background(Rectangle().fill(.brandPurple))
                
                
                VStack{
                    Button {
                        dismiss()
                    } label: {
                        Text("aqui")
                    }
                }
                .background(Rectangle().fill(.blue))
            }
            .brightness(constants.badroomLightIsOn ? 0 : -0.5)
        }
        .navigationBarBackButtonHidden()
        //        .background(Color.background)
    }
}
