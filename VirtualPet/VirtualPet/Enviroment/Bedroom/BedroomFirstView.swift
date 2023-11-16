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
            }
            
            TabbarView()
                .padding(.bottom)
            
        }
        .navigationBarBackButtonHidden()
        
    }
}

