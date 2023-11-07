//
//  Buttons.swift
//  VirtualPet
//
//  Created by Natalia Dal Pizzol on 25/10/23.
//

import Foundation
import SwiftUI

extension Button {
    func buttonPrimary(isDisabled: Bool? = false) -> some View {
        self.buttonStyle(ButtonPrimary(isDisabled: isDisabled))
    }
    
    func buttonSecondary() -> some View {
        self.buttonStyle(ButtonSecondary())
    }
    
    func buttonNavigation() -> some View {
        self.buttonStyle(ButtonNavigation())
    }
    
    func buttonCircle() -> some View {
        self.buttonStyle(ButtonCircle())
    }
    
    func buttonBack() -> some View {
        self.buttonStyle(ButtonBack())
    }
}
