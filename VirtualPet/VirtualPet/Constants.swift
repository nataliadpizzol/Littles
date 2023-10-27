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
    @Published var bath: Int = 0
}

enum Enviroment {
    case mainroom
    case kitchen
    case bathroom
    case bedroom
    case garden
}

class EnviromentTabView: ObservableObject {
    @Published var currentEnviroment: Enviroment = .mainroom
}

//class Coordinator: ObservableObject {
//    
//}
