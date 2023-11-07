//
//  StyleButtonHalfCircle.swift
//  VirtualPet
//
//  Created by Natalia Dal Pizzol on 07/11/23.
//

import SwiftUI

struct ButtonBack: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(configuration.isPressed ? Color.buttonsText : Color.brandColor5)
            .padding()
            Rectangle()
            .foregroundColor(.clear)
            .frame(width: 64, height: 64)
            .background(.brandIcons)
            .clipShape(
                .rect(
                    topLeadingRadius: 111,
                    bottomLeadingRadius: 111,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 0
                )
            )
    }
}
