//
//  FireAnimationColor.swift
//  Challenge-3_Fire-Animation
//
//  Created by Primoz Cuvan on 03.09.22.
//

import SwiftUI

enum FireAnimationColor {
    
    case background, primary, secondary, tertiary
    
    var actualColor: Color {
        switch self {
        case .background:
            return Color(red: 179/255, green: 216/255, blue: 255/255)
        case .primary:
            return Color(red: 255/255, green: 204/255, blue: 0/255)
        case .secondary:
            return Color(red: 254/255, green: 148/255, blue: 0/255)
        case .tertiary:
            return Color(red: 233/255, green: 169/255, blue: 79/255)
        }
    }
}
