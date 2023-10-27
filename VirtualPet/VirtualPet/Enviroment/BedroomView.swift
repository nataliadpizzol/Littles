//
//  BedroomView.swift
//  VirtualPet
//
//  Created by Felipe  Elsner Silva on 24/10/23.
//

import SwiftUI

struct BedroomView: View {
    
    @State var isOn = true
    
    var body: some View {
        VStack{
            Text("Bedroom")
            HStack{
                Rectangle()
                    .foregroundStyle(.blue)
                    .frame(width: 300, height: 300)
                Rectangle()
                    .foregroundStyle(.white)
                    .frame(width: 30, height: 50)
                    .onTapGesture {
                        isOn.toggle()
                    }
            }
            .brightness(isOn ? 0 : -0.5)
            TabbarView()
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    BedroomView()
}
