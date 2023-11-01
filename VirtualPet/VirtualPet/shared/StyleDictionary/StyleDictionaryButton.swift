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
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .font(.silkScreen(.regular))
            .foregroundColor(configuration.isPressed ? Color.brandPink : Color.brandCream)
            .padding()
            .background(configuration.isPressed ? Color.brandBlack : Color.brandPink)
            .background(Color.brandPink)
            .cornerRadius(125)
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
            .buttonStyle(ButtonPrimary())
        }
    }
}


