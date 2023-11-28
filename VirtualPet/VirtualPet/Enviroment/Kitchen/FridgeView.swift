import SwiftUI

struct FridgeView: View {
    
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
                                        ForEach(users) { user in
                                            ForEach(user.itemsArray) { item in
                                                if item.type == "food" {
                                                    ItemComponent(strokeColor: .white, backgroudColor: .yellow, item: item)
                                                        .onTapGesture {
                                                            //pegar a comida e colocar no prato
                                                        }
                                                }
                                            }
                                        }
                                        
                                        ForEach(items) { item in
                                            if !users[0].itemsArray.contains(item) {
                                                if item.type == "food" {
                                                    ItemComponent(strokeColor: .white, backgroudColor: .yellow, item: item)
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
//                                .frame(width: 1, height: 5)
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
}
