//
//  SwiftUIView.swift
//  VirtualPet
//
//  Created by Sofia Sartori on 25/10/23.
//

import SwiftUI

struct NeedsBarComponents: View {
    @ObservedObject var vm = NeedsBarViewModel()
    var image: String
    var enviroment: Enviroment
    var backgroundColor: Color
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var users: FetchedResults<User>
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Circle()
                .foregroundStyle(backgroundColor)
                .frame(width: 60, height: 60)
            
            Circle()
                .frame(width: 60, height: 60)
                .foregroundStyle(vm.getProgressColor(progress: users[0].getProgress(enviroment: enviroment)))
                .mask{
                    VStack {
                        if users[0].getProgress(enviroment: enviroment) < 100 {
                            Spacer()
                        }
                        Rectangle()
                            .frame(width: 60)
                            .frame(height: vm.getProgressHeight(progress: users[0].getProgress(enviroment: enviroment)))
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
    NeedsBarComponents(image: "sleepIcon", enviroment: .mainroom, backgroundColor: Color(uiColor: UIColor.systemTeal))
}
