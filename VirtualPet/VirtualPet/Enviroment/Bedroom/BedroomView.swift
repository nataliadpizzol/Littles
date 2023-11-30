import SwiftUI

struct BedroomView: View {
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var users: FetchedResults<User>
    @ObservedObject var vm = MainroomViewModel()
    @EnvironmentObject var constants: Constants
    @State var navigateToWardrobe: Bool = false
    @State var navigateToBed: Bool = false
    
    var body: some View {
        GeometryReader { reader in
            VStack{
                Spacer()
                VStack{
                    if constants.badroomLightIsOn {
                        ZStack {
                            Image(users.first?.getCurrentBuddy()?.sleep ?? 0 > 70 ? "Pet1-happy" : "Pet1-sad")
                                .resizable()
                                .frame(width: getProportionalValue(300, reader: reader), height: getProportionalValue(180, reader: reader))
                            
                            Image(users.first?.getCurrentBuddy()?.hygiene ?? 100 < 30 ? "Dirty3" : (users.first?.getCurrentBuddy()?.hygiene ?? 100 < 60 ? "Dirty2" : (users.first?.getCurrentBuddy()?.hygiene ?? 100 < 90 ? "Dirty1" : "")))
                                    .resizable()
                                    .frame(width: getProportionalValue(300, reader: reader), height: getProportionalValue(180, reader: reader))
                            
                            if let accessoryImage = users.first?.getCurrentBuddy()?.currentAccessoryImageName {
                                
                                Image(accessoryImage)
                                    .resizable()
                                    .frame(width: getProportionalValue(100, reader: reader), height: getProportionalValue(100, reader: reader))
                                    .position(x: vm.getCGfloat(string: users.first?.getCurrentBuddy()?.accessoryPositionX), y: vm.getCGfloat(string: users.first?.getCurrentBuddy()?.accessoryPositionY) + 43)
                                    .scaleEffect(((users.first?.getCurrentBuddy()?.currentAccessoryImageName?.contains("Glasses"))! || (users.first?.getCurrentBuddy()?.currentAccessoryImageName?.contains("Guitar"))! || (users.first?.getCurrentBuddy()?.currentAccessoryImageName?.contains("Blanket"))!) ? 1.6 : 1)
                                    .onAppear{
                                        print("tem acessorio")
                                    }
                            }
                            Image("Shadow")
                                .resizable()
                                .frame(width: 100, height: 30)
                                .offset(y: 200)
                        }
                        .padding(.top, 160)
                    }
                    else {
                        ZStack {
                            Image(users.first?.getCurrentBuddy()?.sleep ?? 0 > 70 ? "Pet1-happy" : "Pet1-sad")
                                .resizable()
                                .frame(width: getProportionalValue(300, reader: reader), height: getProportionalValue(180, reader: reader))
                            if let accessoryImage = users.first?.getCurrentBuddy()?.currentAccessoryImageName {
                                
                                Image(accessoryImage)
                                    .resizable()
                                    .frame(width: getProportionalValue(100, reader: reader), height: getProportionalValue(100, reader: reader))
                                    .position(x: vm.getCGfloat(string: users.first?.getCurrentBuddy()?.accessoryPositionX), y: vm.getCGfloat(string: users.first?.getCurrentBuddy()?.accessoryPositionY))
                                    .onAppear{
                                        print("tem acessorio")
                                    }
                            }
                        }
                        .hidden()
                        .padding(.top, 160)
                    }
                }
                .position(x: 196, y: 210)

                Spacer()
                VStack {
                    HStack {
                        Button(action: {navigateToWardrobe = true},
                               label: {Image("wardrobeIcon")}
                        )
                        .buttonNavigation()
                        Spacer()
                        Button(action: {navigateToBed = true},
                               label: {Image("bedIcon")}
                        )
                        .buttonNavigation()
                    }
                    .padding()
                    TabbarView()
                }
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0))

            
        }
        .onAppear(perform: {
            constants.currentEnviroment = .mainroom
            constants.currentEnviroment = .bedroom
        })
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $navigateToWardrobe, destination: {WardrobeView(user: users.first!)})
        .navigationDestination(isPresented: $navigateToBed, destination: {BedView()})
    }
    func getProportionalValue(_ value: CGFloat, reader: GeometryProxy) -> CGFloat {
        return value * (reader.size.width / 393)
    }
}
