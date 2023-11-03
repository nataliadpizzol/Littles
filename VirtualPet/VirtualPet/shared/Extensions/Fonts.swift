//
//  Fonts.swift
//  VirtualPet
//
//  Created by Natalia Dal Pizzol on 24/10/23.
//

import Foundation
import SwiftUI

extension Font {
    enum FontSize {
        case logo
        case title
        case subtitle
        case body
        case caption
        case buttonLabel
        
        var value: CGFloat {
            switch self {
            case .logo: return 40
            case .title: return 40
            case .subtitle: return 26
            case .body: return 20
            case .caption: return 18
            case .buttonLabel: return 26
            }
        }
        
        var letterSpacing: Int {
            switch self {
            case .logo: return 0
            case .title: return -2
            case .subtitle: return -2
            case .body: return -2
            case .caption: return 0
            case .buttonLabel: return -2
            }
        }
    }
    
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
    
    static func baloo2(_ type: Baloo2, size: FontSize) -> Font {
        return .custom(type.value, size: size.value)
        
   }
    static func silkScreen(_ type: SilkScreen, size: FontSize) -> Font {
        return .custom(type.value, size: size.value)
   }
    
    static func cherryBombOne(_ type: CherryBombOne, size: FontSize) -> Font {
        return .custom(type.value, size: size.value)
    }
}


