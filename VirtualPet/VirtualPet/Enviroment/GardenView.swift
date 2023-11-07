//
//  GardenView.swift
//  VirtualPet
//
//  Created by Felipe  Elsner Silva on 24/10/23.
//

import SwiftUI

struct GardenView: View {
    var body: some View {
        VStack{
            Text("Garden")
            TabbarView()
        }
        .navigationBarBackButtonHidden()
    }
}
