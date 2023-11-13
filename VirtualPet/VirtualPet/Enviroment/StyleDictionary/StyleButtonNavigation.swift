//
//  StyleButtonNavigation.swift
//  VirtualPet
//
//  Created by Natalia Dal Pizzol on 07/11/23.
//

import SwiftUI

struct ButtonNavigation: ButtonStyle {
    var isDisabled: Bool?
    
        func makeBody(configuration: Configuration) -> some View {
            configuration
                .label
                .foregroundColor(configuration.isPressed ? Color.buttonsText : Color.brandColor5)
                .padding()
                Rectangle()
                .foregroundColor(.clear)
                .frame(width: 40, height: 40)
                .background(.brandIcons)
                .background(configuration.isPressed ? Color.brandColor1 : Color.buttonsBackground)
                .cornerRadius(12)
                .opacity(isDisabled ?? false ? 0.25 : 100)
        }
}

struct ButtonNavigation_Preview: PreviewProvider {
    static var previews: some View {
        VStack {
            Button {
               
            } label: {
                Text("DESCRIPTION")
            }
            // MARK: to use this button style, add ".buttonStyle(ButtonPrimary())" as a modifier to a swiftui button. If the button is to be displayed as disabled, add the parameter "isDisabled: true".
            .buttonStyle(ButtonNavigation())
        }
    }
}
