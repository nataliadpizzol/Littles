//
//  Fonts.swift
//  VirtualPet
//
//  Created by Natalia Dal Pizzol on 24/10/23.
//

import Foundation
import SwiftUI

extension Font {
    public enum FontStyle {
        case logo
        case title
        case subtitle
        case body
        case bold
        case caption
        case buttonLabel
        
        var fontName: String {
            switch self {
            case .logo: return "CherryBombOne-Regular"
            case .title: return "Dangrek-Regular"
            case .subtitle: return "Baloo2-Regular"
            case .body: return "Baloo2-Regular"
            case .bold: return "Baloo2-SemiBold"
            case .caption: return "Baloo2-Medium"
            case .buttonLabel: return "Silkscreen-Regular"
            }
        }
        
        var size: CGFloat {
            switch self {
            case .logo: return 40
            case .title: return 40
            case .subtitle: return 26
            case .body: return 20
            case .bold: return 20
            case .caption: return 18
            case .buttonLabel: return 26
            }
        }
        
        var letterSpacing: CGFloat {
            switch self {
            case .logo: return 0
            case .title: return -2
            case .subtitle: return -2
            case .body: return -2
            case .bold: return -2
            case .caption: return 0
            case .buttonLabel: return -2
            }
        }
    }
    static func fontStyle(_ type: FontStyle) -> Font {
        return .custom(type.fontName, size: type.size)
      }
}

