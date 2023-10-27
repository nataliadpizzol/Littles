//
//  NeedsBarViewModel.swift
//  VirtualPet
//
//  Created by Sofia Sartori on 25/10/23.
//

import Foundation
import SwiftUI

final class NeedsBarViewModel: ObservableObject {
    
    func getProgressHeight(progress: Int) -> CGFloat {
        return CGFloat(progress) / 100 * 60
    }
    
    func getProgressColor(progress: Int) -> Color {
        if progress > 60 {
            return Color(uiColor: UIColor.green)
        }
        if progress > 30 {
            return Color(uiColor: UIColor.yellow)
        }
        return Color(uiColor: UIColor.red)
    }
    
}
