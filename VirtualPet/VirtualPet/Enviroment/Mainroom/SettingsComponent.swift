//
//  Settings.swift
//  VirtualPet
//
//  Created by Natalia Dal Pizzol on 21/11/23.
//

import SwiftUI

struct Settings: View {
    @EnvironmentObject var constants: Constants
    var body: some View {
        ZStack {
            Color.red
            VStack {
                Text("Settings")
                    .font(.fontStyle(.title2))
                VStack(alignment: .leading) {
                    HStack {
                        Image("hapticsIcon")
                        Text("Haptics")
                        Toggle(isOn: $constants.vibration) {
                            
                        }
                        .checkboxToggle()
                    }
                    HStack {
                        Image("soundIcon")
                        Text("Sound")
                        Toggle(isOn: $constants.music) {
                            
                        }
                        .checkboxToggle()
                        
                    }
                }
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
    }
}

#Preview {
    Settings()
}
