//
//  StyleDictionaryButton.swift
//  VirtualPet
//
//  Created by Natalia Dal Pizzol on 25/10/23.
//

import Foundation
import SwiftUI
import UIKit

// custom button style used as primary button in the application
struct ButtonPrimary: ButtonStyle {
    var isDisabled: Bool?
    
    // function to define the appearance and behavior of the button
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .font(.silkScreen(.regular, size: .buttonLabel))
            .tracking(-2)
            .foregroundColor(configuration.isPressed ? Color.buttonsText : Color.brandColor5)
            .padding()
            .background(configuration.isPressed ? Color.brandColor1 : Color.buttonsBackground)
            .cornerRadius(107)
            .overlay(
                RoundedRectangle(cornerRadius: 107)
                .stroke(Color(red: 1, green: 0.98, blue: 0.94), lineWidth: 5)
            )
            .opacity(isDisabled ?? false ? 0.25 : 100)
    }
}

struct ButtonSecondary: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .font(.silkScreen(.regular))
            .foregroundColor(configuration.isPressed ? Color.brandGrey : Color.brandCream)
            .padding()
            .background(configuration.isPressed ? Color.brandBlack : Color.brandGrey)
            .background(Color.brandGrey)
            .cornerRadius(125)
    }
}

struct ButtonPrimary_Preview: PreviewProvider {
    static var previews: some View {
        VStack {
            Button {
                print("Button was tapped")
            } label: {
                Text("Back")
            }
            // MARK: to use this button style, add ".buttonStyle(ButtonPrimary())" as a modifier to a swiftui button. If the button is to be displayed as disabled, add the parameter "isDisabled: true".
            .buttonStyle(ButtonPrimary(isDisabled: false))
        }
    }
}
