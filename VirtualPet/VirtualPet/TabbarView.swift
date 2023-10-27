//
//  TabbarView.swift
//  VirtualPet
//
//  Created by Felipe  Elsner Silva on 24/10/23.
//

import SwiftUI

struct TabbarView: View {
    
    @EnvironmentObject var enviromentTab: EnviromentTabView
    @EnvironmentObject var constants: Constants
    var barColor = Color(uiColor: UIColor.systemTeal)
    
    var body: some View {
        HStack{
            Button {
                enviromentTab.currentEnviroment = .mainroom
            } label: {
                NeedsBarComponents(image: constants.house[0], progress: .constant(100), backgroundColor: barColor)
            }
            .buttonPrimary()
            Button {
                enviromentTab.currentEnviroment = .kitchen
            } label: {
                NeedsBarComponents(image: constants.house[1], progress: .constant(0), backgroundColor: barColor)            }
            
            Button {
                enviromentTab.currentEnviroment = .bathroom
            } label: {
                NeedsBarComponents(image: constants.house[2], progress: $constants.bath, backgroundColor: barColor)
            }
            .buttonPrimary()
            Button {
                enviromentTab.currentEnviroment = .bedroom
            } label: {
                NeedsBarComponents(image: constants.house[3], progress: .constant(0), backgroundColor: barColor)
            }
            .buttonPrimary()
            Button {
                enviromentTab.currentEnviroment = .garden
            } label: {
                NeedsBarComponents(image: constants.house[4], progress: .constant(100), backgroundColor: barColor)
            }
            .buttonPrimary()
        }
    }
}

#Preview {
    TabbarView()
}
