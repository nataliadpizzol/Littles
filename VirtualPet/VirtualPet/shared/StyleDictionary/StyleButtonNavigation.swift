import SwiftUI

struct ButtonNavigation: ButtonStyle {
    var isDisabled: Bool?
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .font(.fontStyle(.buttonLabel))
            .textCase(.uppercase)
            .foregroundColor(configuration.isPressed ? .buttonsBackground : .buttonsText)
            .frame(width: 45, height: 26)
            .padding(EdgeInsets(top: 14, leading: 6, bottom: 16, trailing: 8))
            .background(configuration.isPressed ? .brandColor1 : .buttonsBackground)
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(configuration.isPressed ? .buttonsBackground : .buttonsText), lineWidth: 3)
            )
            .opacity(isDisabled ?? false ? 0.25 : 100)
    }
}

struct ButtonNavigation_Preview: PreviewProvider {
    static var previews: some View {
        VStack {
            Button {
                
            } label: {
                Image("settingsIcon")
            }
            .buttonStyle(ButtonNavigation())
            // MARK: to use this button style, add ".buttonStyle(ButtonPrimary())" as a modifier to a swiftui button. If the button is to be displayed as disabled, add the parameter "isDisabled: true".
        }
    }
}
