import SwiftUI

struct StyleToggleCheckbox: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
            
        }, label: {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.circle" : "circle")
                
                configuration.label
            }
        })
    }
}
