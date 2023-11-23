//
//  TabbarView.swift
//  VirtualPet
//
//  Created by Felipe  Elsner Silva on 24/10/23.
//

import SwiftUI

struct TabbarView: View {
    @EnvironmentObject var constants: Constants
    var barColor = Color(uiColor: UIColor.systemTeal)
    
    var body: some View {
        HStack(spacing: 30){
            Button {
                constants.currentEnviroment = .mainroom
            } label: {
                NeedsBarComponents(image: Enviroment.mainroom.getIconAsset(), enviroment: .mainroom)
            }
            
            Button {
                constants.currentEnviroment = .kitchen
            } label: {
                NeedsBarComponents(image: Enviroment.kitchen.getIconAsset(), enviroment: .kitchen)
            }
            
            Button {
                constants.currentEnviroment = .bathroom
            } label: {
                NeedsBarComponents(image: Enviroment.bathroom.getIconAsset(), enviroment: .bathroom)
            }
            
            Button {
                constants.currentEnviroment = .bedroom
            } label: {
                NeedsBarComponents(image: Enviroment.bedroom.getIconAsset(), enviroment: .bedroom)
            }
            
//            Button {
//                constants.currentEnviroment = .garden
//            } label: {
//                NeedsBarComponents(image: constants.house[4], enviroment: .garden)
//            }
        }
    }
}

#Preview {
    TabbarView()
}
