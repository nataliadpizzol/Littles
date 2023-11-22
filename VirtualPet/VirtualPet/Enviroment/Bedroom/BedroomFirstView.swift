// PRIMEIRA TELA QUARTO

import SwiftUI

struct BedroomFirstView: View {
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var users: FetchedResults<User>
    
    @ObservedObject var vm = MainroomViewModel()
    
    @EnvironmentObject var constants: Constants
    
    var body: some View {
        GeometryReader { reader in
            VStack{
                Spacer()
                VStack{
                    if constants.badroomLightIsOn {
                        ZStack {
                            Image(users.first?.getCurrentBuddy()?.sleep ?? 0 > 70 ? "Pet1-happy" : "Pet1-sad")
                                .resizable()
                                .frame(width: getProportionalValue(300, reader: reader), height: getProportionalValue(150, reader: reader))
                            if let accessoryImage = users.first?.getCurrentBuddy()?.currentAccessoryImageName {
                                
                                Image(accessoryImage)
                                    .resizable()
                                    .frame(width: getProportionalValue(100, reader: reader), height: getProportionalValue(100, reader: reader))
                                    .position(x: vm.getCGfloat(string: users.first?.getCurrentBuddy()?.accessoryPositionX), y: vm.getCGfloat(string: users.first?.getCurrentBuddy()?.accessoryPositionY))
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
                                .frame(width: getProportionalValue(300, reader: reader), height: getProportionalValue(150, reader: reader))
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
                Spacer()
                HStack {
                    NavigationLink {
                        InventoryList()
                    } label: {
                        ZStack {
                            Image("wardrobeIcon")
                                .resizable()
                                .frame(width: 50, height: 50)
                        }
                    }
                    .padding()
                    
                    Spacer()
                    
                    NavigationLink {
                        BedroomView()
                    } label: {
                        ZStack {
                            Image("sleep")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundStyle(.buttonsText)
                        }
                    }
                    .padding()
                }
                .padding()
                TabbarView()
                    .padding(.bottom)
            }
            
        }
        .navigationBarBackButtonHidden()
    }
    func getProportionalValue(_ value: CGFloat, reader: GeometryProxy) -> CGFloat {
        return value * (reader.size.width / 393)
    }
}

