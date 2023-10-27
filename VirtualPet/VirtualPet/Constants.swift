//
//  Constants.swift
//  VirtualPet
//
//  Created by Felipe  Elsner Silva on 24/10/23.
//

import Foundation

class Constants: ObservableObject {
    static let shared: Constants = Constants()
    
    @Published var house: [String] = ["sofa.fill", "fork.knife", "bathtub.fill", "bed.double.fill", "tree.fill"]
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
