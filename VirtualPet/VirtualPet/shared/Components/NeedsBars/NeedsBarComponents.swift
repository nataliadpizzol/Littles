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
    var progressColor: Color
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .foregroundStyle(backgroundColor)
                .frame(width: 60, height: 60)
            VStack {
                if progress < 100 {
                    Spacer()
                }
                Rectangle()
                    .foregroundStyle(progressColor)
                    .frame(width: 60)
                    .frame(height: vm.getProgressHeight(progress: progress))
                
            }.frame(height: 60)
            Image(image)
                .resizable()
                .frame(width: 50, height: 50)
        }.frame(height: 60)
    }
    
}

#Preview {
    NeedsBarComponents(image: "sleepIcon", progress: .constant(100), backgroundColor: Color(uiColor: UIColor.systemTeal), progressColor: Color(uiColor: UIColor.green))
}
