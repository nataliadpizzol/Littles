import SwiftUI

struct ButtonBack: ButtonStyle {
    var isDisabled: Bool?
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .font(.fontStyle(.buttonLabel))
            .textCase(.uppercase)
            .foregroundColor(configuration.isPressed ? .buttonsBackground : .buttonsText)
            .padding(12)
            .background(configuration.isPressed ? .brandColor1 : .buttonsBackground)
            .cornerRadius(132)
            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
            .overlay(
                RoundedRectangle(cornerRadius: 132)
                    .stroke(Color(configuration.isPressed ? .buttonsBackground : .buttonsText), lineWidth: 3)
            )
            .opacity(isDisabled ?? false ? 0.25 : 100)
    }
}
