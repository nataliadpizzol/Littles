//
//  BathroomView.swift
//  VirtualPet
//
//  Created by Felipe  Elsner Silva on 24/10/23.
//

import SwiftUI

struct BathroomView: View {
    
    var body: some View {
        VStack {
            Text("Bathroom")
            HStack {
                Rectangle()
                    .size(CGSize(width: 100, height: 100))
            }
            TabbarView()
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    BathroomView()
}
