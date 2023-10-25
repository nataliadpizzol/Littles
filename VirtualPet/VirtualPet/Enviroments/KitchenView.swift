//
//  KitchenView.swift
//  VirtualPet
//
//  Created by Felipe  Elsner Silva on 24/10/23.
//

import SwiftUI

struct KitchenView: View {
    
    var body: some View {
        VStack{
            Text("Kitchen")
            TabbarView()
            
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    KitchenView()
}
