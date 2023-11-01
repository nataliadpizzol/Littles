//
//  MainroomView.swift
//  VirtualPet
//
//  Created by Felipe  Elsner Silva on 25/10/23.
//

import SwiftUI

struct MainroomView: View {
    
    @ObservedObject var vm = MainroomViewModel()
    @State var isPetting: Bool = false
    @EnvironmentObject var constants: Constants
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var users: FetchedResults<User>
    
    var petting: some Gesture {
        DragGesture()
            .onChanged { _ in
                if let cb = users.first?.getCurrentBuddy(), cb.entertainmet < 100 {
                    isPetting = true
                    cb.entertainmet = cb.entertainmet + 1
                    print(cb.entertainmet)
                    do {
                        try managedObjectContext.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                else {
                    if let cb = users.first?.getCurrentBuddy(){
                        print(cb.entertainmet)                        
                    }
                    self.isPetting = true
                }
                constants.objectWillChange.send()
            }
            .onEnded { _ in
                self.isPetting = false
            }
    }
    
    var body: some View {
        VStack {
            Text("Mainroom")
                HStack{
                    ZStack {
                        Circle()
                            .foregroundStyle(self.isPetting ? .red : .blue)
                            .frame(width: 200, height: 200)
                        if let accessoryImage = users.first?.getCurrentBuddy()?.currentAccessoryImageName {
                            
                            Image(accessoryImage)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .position(x: vm.getCGfloat(string: users.first?.getCurrentBuddy()?.accessoryPositionX), y: vm.getCGfloat(string: users.first?.getCurrentBuddy()?.accessoryPositionY))
                                .onAppear{
                                    print("tem acessorio")
                                }
                        }
                    }.gesture(petting)te
                }.onAppear {
                    /// Change Later
                    users.first?.getCurrentBuddy()?.currentAccessoryImageName = "WardrobeAccessory1"
                    users.first?.getCurrentBuddy()?.accessoryPositionX = "200"
                    users.first?.getCurrentBuddy()?.accessoryPositionY = "250"
                    do {
                        try managedObjectContext.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                    print(users.first?.getCurrentBuddy()?.currentAccessoryImageName)
                    print(users.first?.getCurrentBuddy()?.accessoryPositionX)
                }
            
            TabbarView()
        }
        .navigationBarBackButtonHidden()
    }
}

//#Preview {
//    MainroomView(enterteinment: .constant(20))
//}
