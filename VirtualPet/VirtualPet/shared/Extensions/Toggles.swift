//
//  Toggles.swift
//  VirtualPet
//
//  Created by Natalia Dal Pizzol on 21/11/23.
//

import Foundation
import SwiftUI

extension Toggle {
    func checkboxToggle() -> some View {
        self.toggleStyle(StyleToggleCheckbox())
    }
}
