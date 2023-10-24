//
//  Fonts.swift
//  VirtualPet
//
//  Created by Natalia Dal Pizzol on 24/10/23.
//

import Foundation
import SwiftUI

extension Font {
    enum Baloo2 {
        case extraBold
        case bold
        case semibold
        case medium
        case regular
        
        var value: String {
            switch self {
            case .extraBold: return "Baloo2-ExtraBold"
            case .bold: return "Baloo2-Bold"
            case .semibold: return "Baloo2-SemiBold"
            case .medium: return "Baloo2-Medium"
            case .regular: return "Baloo2-Regular"
            }
        }
    }
    
    enum SilkScreen {
        case bold
        case regular
        
        var value: String {
            switch self {
            case .bold: return "Silkscreen-Bold"
            case .regular: return "Silkscreen-Regular"
            }
        }
    }
    enum CherryBombOne {
        case regular
        
        var value: String {
            switch self {
            case .regular: return "CherryBombOne-Regular"
            }
        }
    }
    
    static func baloo2(_ type: Baloo2, size: CGFloat = 26) -> Font {
           return .custom(type.value, size: size)
   }
    static func silkScreen(_ type: SilkScreen, size: CGFloat = 26) -> Font {
           return .custom(type.value, size: size)
   }
    
    static func cherryBombOne(_ type: CherryBombOne, size: CGFloat = 26) -> Font {
        return .custom(type.value, size: size)
    }
}
