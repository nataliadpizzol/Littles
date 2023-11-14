//
//  BeedroomFirstView.swift
//  VirtualPet
//
//  Created by Sofia Sartori on 13/11/23.
//

import SwiftUI

struct BedroomFirstView: View {
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var users: FetchedResults<User>
    
    @ObservedObject var vm = MainroomViewModel()
    
    @EnvironmentObject var constants: Constants
    
    var body: some View {
        VStack {
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
                    .padding(.top, 160)
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
                HStack {
                    NavigationLink {
                        InventoryList()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: 50, height: 50)
                                .foregroundStyle(.brandIcons)
                            Image("wardrobeIcon")
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                    }
                    .padding()
                    
                    Spacer()
                    
                    NavigationLink {
                        BedroomView()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: 50, height: 50)
                                .foregroundStyle(.brandIcons)
                            Image("sleepIcon")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundStyle(.buttonsText)
                        }
                    }
                    .padding()
                }
                .brightness(constants.badroomLightIsOn ? 0 : 0.5)
            }
            .brightness(constants.badroomLightIsOn ? 0 : -0.5)
            
            TabbarView()
                .padding(.bottom)
            
        }
        .navigationBarBackButtonHidden()
        
    }
}

