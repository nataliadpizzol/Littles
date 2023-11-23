//
//  StyleButtonHalfCircle.swift
//  VirtualPet
//
//  Created by Natalia Dal Pizzol on 07/11/23.
//

import SwiftUI

struct ButtonBack: ButtonStyle {
    var isDisabled: Bool?

    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .font(.fontStyle(.buttonLabel))
            .textCase(.uppercase)
            .foregroundColor(configuration.isPressed ? .buttonsBackground : .buttonsText)
            .frame(width: 45, height: 26)
            Rectangle()
            .foregroundColor(.clear)
            .frame(width: 64, height: 64)
            .background(configuration.isPressed ? .brandColor1 : .buttonsBackground)            
            .cornerRadius(138)
            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
            .overlay(
                RoundedRectangle(cornerRadius: 138)
                    .stroke(Color(configuration.isPressed ? .buttonsBackground : .buttonsText), lineWidth: 3)

            )
            .opacity(isDisabled ?? false ? 0.25 : 100)
    }
}
