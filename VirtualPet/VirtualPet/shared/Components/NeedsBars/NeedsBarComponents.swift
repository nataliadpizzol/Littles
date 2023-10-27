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
    @Binding var progress: Int
    var backgroundColor: Color
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Circle()
                .foregroundStyle(backgroundColor)
                .frame(width: 60, height: 60)
            
            Circle()
                .frame(width: 60, height: 60)
                .foregroundStyle(vm.getProgressColor(progress: progress))
                .mask{
                    VStack {
                        if progress < 100 {
                            Spacer()
                        }
                        Rectangle()
                            .frame(width: 60)
                            .frame(height: vm.getProgressHeight(progress: progress))
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
    NeedsBarComponents(image: "sleepIcon", progress: .constant(30), backgroundColor: Color(uiColor: UIColor.systemTeal), progressColor: Color(uiColor: UIColor.green))
}
