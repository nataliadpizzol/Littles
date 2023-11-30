import SwiftUI

struct FridgeView: View {
    
    @Binding var food: String
    
    @Environment(\.managedObjectContext) var managedObjContext
    @ObservedObject var vm = MainroomViewModel()
    @EnvironmentObject var constants: Constants
    @Environment(\.dismiss) var dismiss
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\Item.name)],
        animation: .default)
    private var items: FetchedResults<Item>
    var user: User
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var users: FetchedResults<User>
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @State var showBuyPopUp = false
    @State var foodNumber: Int? = 0
    @State var showAlert: Bool = false
    @State var itemToBuy: Item?
    
    var body: some View {
        GeometryReader { reader in
            VStack{
                VStack{
                    VStack{
                    }
                    .frame(height: 160)
                    
                    VStack(spacing: 0){
                        ZStack (alignment: .top){
                            Rectangle()
                                .fill(.brandBlue2)
                                .frame(width: UIScreen.main.bounds.width, height: 60)
                            
                            VStack {
                                ScrollView{
                                    LazyVGrid(columns: columns) {
                                        //ele ja tem
                                        if let itemsList = users.first?.itemsArray {
                                            ForEach(itemsList) { item in
                                                if item.type == "food" {
                                                    ItemComponent(strokeColor: .white, backgroudColor: .yellow, item: item, foodCount: $foodNumber, itemType: .food)
                                                        .padding()
                                                        .onTapGesture {
                                                            if let photo = item.photo {
                                                                self.food = photo
                                                                showAlert.toggle()
                                                                itemToBuy = item
                                                            }
                                                        }
                                                        .onAppear{
                                                            self.foodNumber = countFood(food: item)
                                                        }
                                                    
                                                }
                                            }
                                            
                                            ForEach(items) { item in
                                                if !itemsList.contains(item) {
                                                    if item.type == "food" {
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
                            .padding(.top, 80)
                            .padding(.horizontal, 20)
                        }
                    }
                    .brightness(constants.badroomLightIsOn ? 0 : 0.5)
                    .background(Rectangle().fill(.brandBlue))
                    
                }
                
                VStack{
                    HStack{
                        Button(action: {dismiss()},
                               label: {
                            Image("backButtonIcon")
                        })
                        .buttonBack()
                        .padding(.leading, 30)
                        .padding(.bottom, 40)
                        Spacer()
                    }
                }
                .frame(width: UIScreen.main.bounds.width, height: 50)
                .background(Image("backgroudKitchenBuyScreen")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width, height: 120))
            }
            .background(
                Image("backgroundKitchen2")
                    .resizable()
                    .ignoresSafeArea()
            )
            .toolbar(content: {
                HStack{
                    XPBarComponent()
                        .padding(.trailing, 65)
                    CoinsComponent()
                }
            })
            .brightness(constants.badroomLightIsOn ? 0 : -0.5)
            .alert("Do you want to buy a new item or use it? ", isPresented: $showAlert) {
                Button("Buy") {constants.selectedItem = self.itemToBuy}
                Button("Use", role: .cancel) { dismiss()}
            }
            
            if constants.selectedItem != nil {
                BuyComponent(item: constants.selectedItem!, user: user, managedObjectContext: managedObjContext)
                    .padding(EdgeInsets(top: 200, leading: 40, bottom: 200, trailing: 40))
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    func getProportionalValue(_ value: CGFloat, reader: GeometryProxy) -> CGFloat {
        return value * (reader.size.width / 393)
    }
    
    func countFood(food: Item?) -> Int {
        var count: Int = 0
        if let wpFood = food {
            if let itens = users.first?.itemsArray {
                for item in itens {
                    if let name = item.name {
                        if name == wpFood.name {
                            count += 1
                        }
                    }
                }
            }
            
        }
        return count
    }
}
