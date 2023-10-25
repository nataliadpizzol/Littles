//
//  TabbarView.swift
//  VirtualPet
//
//  Created by Felipe  Elsner Silva on 24/10/23.
//

import SwiftUI

struct TabbarView: View {
    
    @EnvironmentObject var enviromentTab: EnviromentTabView
    
    var body: some View {
        HStack{
            Button {
                enviromentTab.currentEnviroment = .mainroom
            } label: {
                Image(systemName: Constants.shared.house[0])
            }
            
            Button {
                enviromentTab.currentEnviroment = .kitchen
            } label: {
                Image(systemName: Constants.shared.house[1])
            }
            
            Button {
                enviromentTab.currentEnviroment = .bathroom
            } label: {
                Image(systemName: Constants.shared.house[2])
            }
            
            Button {
                enviromentTab.currentEnviroment = .bedroom
            } label: {
                Image(systemName: Constants.shared.house[3])
            }
            
            Button {
                enviromentTab.currentEnviroment = .garden
            } label: {
                Image(systemName: Constants.shared.house[4])
            }
        }
    }
}

#Preview {
    TabbarView()
}
