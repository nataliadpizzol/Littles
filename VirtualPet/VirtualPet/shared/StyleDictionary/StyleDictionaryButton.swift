//
//  StyleDictionaryButton.swift
//  VirtualPet
//
//  Created by Natalia Dal Pizzol on 25/10/23.
//

import Foundation
import SwiftUI
import UIKit

struct ButtonPrimary: ButtonStyle {
    var isDisabled: Bool?
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .font(.silkScreen(.regular))
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

struct ButtonPrimary_Preview: PreviewProvider {
    static var previews: some View {
        VStack {
            Button {
                print("Button was tapped")
            } label: {
                Text("Back")
            }
            .buttonStyle(ButtonPrimary())
        }
    }
}


