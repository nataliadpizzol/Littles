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
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var users: FetchedResults<User>
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @State var showBuyPopUp = false
    @State var foodNumber: Int? = 0

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
                            VStack{
                                Image("Food")
                                    .resizable()
                                    .frame(width: 40, height: 35)
                                    .padding(.trailing, 200)
                            }
                            VStack {
                                ScrollView{
                                    LazyVGrid(columns: columns) {
                                        //ele ja tem
                                        if let itemsList = users.first?.itemsArray {
                                            ForEach(itemsList) { item in
                                                if item.type == "food" {
                                                    ItemComponent(strokeColor: .white, backgroudColor: .yellow, item: item, foodCount: $foodNumber, itemType: .food)
                                                        .onTapGesture {
                                                            if let photo = item.photo {
                                                                self.food = photo
                                                                dismiss()
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
            
           if constants.selectedItem != nil {
                BuyComponent(item: constants.selectedItem!)
                    .padding(EdgeInsets(top: 200, leading: 60, bottom: 200, trailing: 60))
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
                    if let id = item.id {
                        if id == wpFood.id {
                            count += 1
                        }
                    }
                }
            }
            
        }
        return count
    }
}
