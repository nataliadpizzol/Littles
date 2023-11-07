//
//  SwiftUIView.swift
//  VirtualPet
//
//  Created by Sofia Sartori on 25/10/23.
//

import SwiftUI
import CoreData

struct NeedsBarComponents: View {
    var image: String
    var enviroment: Enviroment
    @ObservedObject var vm = NeedsBarViewModel()
    @EnvironmentObject var constant: Constants
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var users: FetchedResults<User>
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var virtualPet: FetchedResults<VirtualPet>
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Circle()
                .foregroundStyle(.brandIcons)
                .frame(width: 60, height: 60)
            
            Circle()
                .frame(width: 60, height: 60)
                .foregroundStyle(vm.getProgressColor(progress: users.first?.getProgress(enviroment: enviroment) ?? 0))
                .mask{
                    VStack {
                        if let user = users.first, user.getProgress(enviroment: enviroment) < 100 {
                            Spacer()
                        }
                        
                        Rectangle()
                            .frame(width: 60)
                            .frame(height: vm.getProgressHeight(progress: users.first != nil ? users[0].getProgress(enviroment: enviroment) : 0))
                    }.frame(height: 60)
                }
            
            Image(image)
                .resizable()
                .frame(width: 40, height: 40)
                .padding()
            
        }
    }
}

#Preview {
    NeedsBarComponents(image: "sleepIcon", enviroment: .mainroom)
}
