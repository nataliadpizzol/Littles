//
//  NeedsBarViewModel.swift
//  VirtualPet
//
//  Created by Sofia Sartori on 25/10/23.
//

import Foundation

final class NeedsBarViewModel: ObservableObject {
    
    func getProgressHeight(progress: Int) -> CGFloat {
        return CGFloat(progress) / 100 * 60
    }
    
}
