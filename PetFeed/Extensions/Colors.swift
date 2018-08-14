//
//  Colors.swift
//  PetFeed
//
//  Created by 이창현 on 2018. 8. 6..
//  Copyright © 2018년 이창현. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}


extension UIColor {
    
    @nonobjc class var black30: UIColor {
        return UIColor(white: 32.0 / 255.0, alpha: 0.3)
    }
    
    @nonobjc class var camoGreen10: UIColor {
        return UIColor(red: 68.0 / 255.0, green: 45.0 / 255.0, blue: 38.0 / 255.0, alpha: 0.1)
    }
    
    @nonobjc class var black: UIColor {
        return UIColor(white: 32.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var veryLightPink: UIColor {
        return UIColor(red: 1.0, green: 249.0 / 255.0, blue: 245.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var camoGreen: UIColor {
        return UIColor(red: 68.0 / 255.0, green: 45.0 / 255.0, blue: 38.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var grapefruit: UIColor {
        return UIColor(red: 1.0, green: 85.0 / 255.0, blue: 85.0 / 255.0, alpha: 1.0)
    }
    
}
