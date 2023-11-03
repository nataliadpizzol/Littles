//
//  Buttons.swift
//  VirtualPet
//
//  Created by Natalia Dal Pizzol on 25/10/23.
//

import Foundation
import SwiftUI

extension Button {
    func buttonPrimary() -> some View {
        self.buttonStyle(ButtonPrimary())
    }
    
    func buttonSecondary() -> some View {
        self.buttonStyle(ButtonSecondary())
    }
}
