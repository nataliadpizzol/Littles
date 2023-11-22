//
//  StyleButtonPrimary.swift
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
            .font(.fontStyle(.buttonLabel))
            .textCase(.uppercase)
            .tracking(-2)
            .foregroundColor(configuration.isPressed ? .buttonsBackground : .buttonsText)
            .padding()
            .background(configuration.isPressed ? .buttonsText : .buttonsBackground)
            .cornerRadius(107)
            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
            .overlay(
                RoundedRectangle(cornerRadius: 107)
                    .stroke(Color(configuration.isPressed ? .buttonsBackground : .buttonsText), lineWidth: 5)
            )
            .opacity(isDisabled ?? false ? 0.25 : 100)
    }
}

struct ButtonSecondary: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .font(.fontStyle(.buttonLabel))
            .foregroundColor(configuration.isPressed ? Color.brandGrey : Color.brandColor5)
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
            .buttonStyle(ButtonPrimary())
        }
    }
}
