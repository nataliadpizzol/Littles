//
//  MainroomViewModel.swift
//  VirtualPet
//
//  Created by Sofia Sartori on 01/11/23.
//

import Foundation

final class MainroomViewModel: ObservableObject {
    func getCGfloat(string: String?) -> CGFloat {
        guard let uwString = string else {
            return 0
        }
        if let floatValue = Float(uwString) {
            let cgFloatValue = CGFloat(floatValue)
            return cgFloatValue
        }
        return 0
    }
}
