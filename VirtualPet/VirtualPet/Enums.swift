//
//  Enums.swift
//  VirtualPet
//
//  Created by Natalia Dal Pizzol on 23/10/23.
//

import Foundation

enum EvolutionStage{
    case egg, baby, teenager, adult
}

enum Specie {
    case value1, value2, value3
}

enum ItemType {
    case egg, boost, food, acessory
}

enum Needs {
    case sleep, hunger, hygiene, entertainment
}

enum Enviroment {
    case mainroom, kitchen, bathroom, bedroom //garden
    
    func getIconAsset() -> String {
        switch self {
        case .mainroom:
            return "funIcon"
        case .kitchen:
            return "hungryIcon"
        case .bathroom:
            return "cleanIcon"
        case .bedroom:
            return "sleepIcon"
        }
    }
    
    func getbackground() -> String {
        switch self {
        case .mainroom:
            return "backgroudMainroom"
        case .kitchen:
            return "backgroundKitchen"
        case .bathroom:
            return "backgroudBathroom"
        case .bedroom:
            return Constants().badroomLightIsOn ? "backgroudBedroom" : "backgroudBedroomOff"
            //        case .garden:
            //            return "backgroudGarden"
        }
    }
}


// TERMINAR AQUI O ENUM PARA CORRIGIR
//enum Wardrobe {
//    case glasses, handBody, hats
//    
//    @Published var currentWardrobe: Wardrobe = .glasses
//    
//    func buttonWardrobe () -> Wardrobe {
//        switch currentWardrobe {
//        case .glasses:
//
//        case .handBody:
//
//        case .hats:
//
//        }
//    }
//}


