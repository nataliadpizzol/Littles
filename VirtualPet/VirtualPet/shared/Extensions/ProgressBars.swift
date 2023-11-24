//
//  ProgressBars.swift
//  VirtualPet
//
//  Created by Natalia Dal Pizzol on 24/11/23.
//

import Foundation
import SwiftUI

extension ProgressView {
    func progressBarPrimary(icon: String) -> some View {
        self.progressViewStyle(ProgressBarPrimary(icon: icon))
    }
}
