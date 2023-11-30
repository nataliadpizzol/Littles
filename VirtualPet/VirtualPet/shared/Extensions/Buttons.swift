import Foundation
import SwiftUI

extension Button {
    func buttonPrimary(isDisabled: Bool? = false) -> some View {
        self.buttonStyle(ButtonPrimary(isDisabled: isDisabled))
    }
    
    func buttonSecondary() -> some View {
        self.buttonStyle(ButtonSecondary())
    }
    
    func buttonNavigation(isDisabled: Bool? = false) -> some View {
        self.buttonStyle(ButtonNavigation(isDisabled: isDisabled))
    }
    
    func buttonCircle(isDisabled: Bool? = false) -> some View {
        self.buttonStyle(ButtonCircle(isDisabled: isDisabled))
    }
    
    func buttonBack(isDisabled: Bool? = false) -> some View {
        self.buttonStyle(ButtonBack(isDisabled: isDisabled))
    }
}
