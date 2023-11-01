//
//  Constants.swift
//  VirtualPet
//
//  Created by Felipe  Elsner Silva on 24/10/23.
//

import Foundation
import SwiftUI

class Constants: ObservableObject {
    
    @Published var house: [String] = ["funIcon", "hungryIcon", "cleanIcon", "sleepIcon", "gardenIcon"]
    
    @Published var currentEnviroment: Enviroment = .mainroom
    
    @Published var badroomLightIsOn = true
}
