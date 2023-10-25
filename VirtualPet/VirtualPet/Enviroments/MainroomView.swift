//
//  MainroomView.swift
//  VirtualPet
//
//  Created by Felipe  Elsner Silva on 25/10/23.
//

import SwiftUI

struct MainroomView: View {
    var body: some View {
        VStack{
            Text("Main room")
            TabbarView()
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    MainroomView()
}
