//
//  StyleButtonCircle.swift
//  VirtualPet
//
//  Created by Natalia Dal Pizzol on 07/11/23.
//

import SwiftUI

struct ButtonCircle: ButtonStyle {
    var isDisabled: Bool?

    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(configuration.isPressed ? .buttonsBackground : .buttonsText)
            .padding()
            Rectangle()
            .foregroundColor(.brandIcons)
            .frame(width: 50, height: 50)
            .cornerRadius(86)
            .opacity(isDisabled ?? false ? 0.25 : 100)
    }
}

