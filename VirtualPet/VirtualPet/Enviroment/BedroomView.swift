//
//  BedroomView.swift
//  VirtualPet
//
//  Created by Felipe  Elsner Silva on 24/10/23.
//

import SwiftUI

struct BedroomView: View {
    var body: some View {
        VStack{
            Text("Bedroom")
            TabbarView()
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    BedroomView()
}
