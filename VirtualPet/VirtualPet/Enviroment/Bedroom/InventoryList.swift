import SwiftUI

struct InventoryList: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm = MainroomViewModel()
    @EnvironmentObject var constants: Constants
    @FetchRequest(
<<<<<<< HEAD
        sortDescriptors: [SortDescriptor(\Item.name)],
        animation: .default)
    private var items: FetchedResults<Item>
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var users: FetchedResults<User>
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @State var itemPopUp: Item?
    
=======
        sortDescriptors: [],
        animation: .default)
    private var users: FetchedResults<User>
        
>>>>>>> Dev
    var body: some View {
        GeometryReader { reader in
            ZStack {
                VStack{
                    VStack{
                        VStack{
                            //Image("Pet1-happy\(item)")
                            Image("Pet1-happy")
                                .resizable()
                                .frame(width: 300, height: 160)
                        }
                        .frame(height: 260)

                        VStack(spacing: 0){
                            ZStack (alignment: .top){
                                Rectangle()
                                    .fill(.brandPurple2)
                                    .frame(width: UIScreen.main.bounds.width, height: 60)
                                VStack {
                                    TabbarWardrobe()
                                        .padding(.bottom)
                                    HStack {
                                        switch constants.currentWardrobe {
                                        case .glasses:
                                            TabbarWardobeView(accessoryType: "glasses")
                                        case .handBody:
                                            TabbarWardobeView(accessoryType: "handBody")
                                        case .hat:
                                            TabbarWardobeView(accessoryType: "hat")
                                        }
                                    }
                                }
                            }
                        }
                        .brightness(constants.badroomLightIsOn ? 0 : 0.5)
                        .background(Rectangle().fill(.brandPurple))
                        
<<<<<<< HEAD
                    }
                    
                    VStack{
                        HStack{
                            Button(action: {dismiss()},
                                   label: {Image("backButtonIcon")}
                            )
                            .buttonBack()
                            Spacer()
=======
                        VStack{
                            HStack{
                                Button {
                                    dismiss()
                                } label: {
                                    Image("backButton")
                                        .resizable()
                                        .frame(width: 64, height: 64)
                                        .padding()
                                        .padding(.bottom, 32)
                                }
                                Spacer()
                            }
>>>>>>> Dev
                        }
                        .frame(width: UIScreen.main.bounds.width, height: 50)
                        .background(Image("backgroudWardrobeBuyScreen")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width, height: 120))
                    }
                }
                .background(
                    Image("backgroudWardrobe")
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
            
        }
        .navigationBarBackButtonHidden(true)
    }

    
    func getProportionalValue(_ value: CGFloat, reader: GeometryProxy) -> CGFloat {
        return value * (reader.size.width / 393)
    }
}


//            .resizable()
//            .frame(width: UIScreen.main.bounds.width, height: 80)
//            .scaledToFill()
