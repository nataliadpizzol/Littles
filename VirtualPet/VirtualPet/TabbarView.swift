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
        HStack{
            Button {
                constants.currentEnviroment = .mainroom
            } label: {
                NeedsBarComponents(image: constants.house[0], enviroment: .mainroom, backgroundColor: barColor)
            }
            
            Button {
                constants.currentEnviroment = .kitchen
            } label: {
                NeedsBarComponents(image: constants.house[1], enviroment: .kitchen, backgroundColor: barColor)            }
            
            Button {
                constants.currentEnviroment = .bathroom
            } label: {
                NeedsBarComponents(image: constants.house[2], enviroment: .bathroom, backgroundColor: barColor)
            }
            
            Button {
                constants.currentEnviroment = .bedroom
            } label: {
                NeedsBarComponents(image: constants.house[3], enviroment: .bedroom, backgroundColor: barColor)
            }
            
            Button {
                constants.currentEnviroment = .garden
            } label: {
                NeedsBarComponents(image: constants.house[4], enviroment: .garden, backgroundColor: barColor)
            }
        }
    }
}

#Preview {
    TabbarView()
}
