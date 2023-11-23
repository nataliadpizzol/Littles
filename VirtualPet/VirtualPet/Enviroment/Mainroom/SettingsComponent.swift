//
//  Settings.swift
//  VirtualPet
//
//  Created by Natalia Dal Pizzol on 21/11/23.
//

import SwiftUI

struct SettingsComponent: View {
    @EnvironmentObject var constants: Constants
    @State var isActive: Bool = true
    @Binding var showSettings: Bool
    
    func close() {
        withAnimation(.spring()) {
            isActive = false
            
        }
    }
    var body: some View {
        VStack(spacing: 4) {
            Text("Settings")
                .font(.fontStyle(.title2))
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Image("hapticsIcon")
                    Text("Haptics")
                        .font(.fontStyle(.bold))
                    Spacer()
                    Toggle(isOn: $constants.vibration) {
                        
                    }
                    .checkboxToggle()
                }
                HStack {
                    Image("soundIcon")
                    Text("Sound")
                        .font(.fontStyle(.bold))
                    Spacer()
                    Toggle(isOn: $constants.music) {
                    }
                    .checkboxToggle()
                }
            }
            Button("save", action: {showSettings.toggle()})
                .buttonPrimary()
                .padding(.top, 30)
        }
        .padding(EdgeInsets(top: 32, leading: 24, bottom: 24, trailing: 24))
        .foregroundStyle(.white)
        .background(.popUp)
        .cornerRadius(24)
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .inset(by: -2.5)
                .stroke(.white, lineWidth: 5)
        )
    }
}

