//
//  StyleButtonCircle.swift
//  VirtualPet
//
//  Created by Natalia Dal Pizzol on 07/11/23.
//

import SwiftUI

struct ButtonCircle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(configuration.isPressed ? Color.buttonsText : Color.brandColor5)
            .padding()
            Rectangle()
            .foregroundColor(.clear)
            .frame(width: 40, height: 40)
            .background(.brandIcons)
            .cornerRadius(86)
    }
}

