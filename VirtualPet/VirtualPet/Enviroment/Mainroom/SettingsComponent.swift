import SwiftUI

struct SettingsComponent: View {
    @EnvironmentObject var constants: Constants
    @Binding var showSettings: Bool
    
    var body: some View {
        VStack(spacing: 4) {
            Text("Settings")
                .font(.fontStyle(.title2))
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Image("hapticsIcon")
                    Text("Haptics")
                        .font(.fontStyle(.bold))
                    Spacer()
                    Toggle(isOn: $constants.vibration) {
                        
                    }
                    .checkboxToggle()
                }
                HStack {
                    Image("soundIcon")
                    Text("Sound")
                        .font(.fontStyle(.bold))
                    Spacer()
                    Toggle(isOn: $constants.music) {
                    }
                    .checkboxToggle()
                }
            }
            Button("save", action: {showSettings.toggle()})
                .buttonPrimary()
                .padding(.top, 30)
        }
        .padding(EdgeInsets(top: 32, leading: 24, bottom: 24, trailing: 24))
        .foregroundStyle(.white)
        .background(.popUp)
        .cornerRadius(24)
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .inset(by: -2.5)
                .stroke(.white, lineWidth: 5)
        )
    }
}

