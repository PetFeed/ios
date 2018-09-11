//
//  Double.swift
//  PetFeed
//
//  Created by 이창현 on 2018. 9. 11..
//  Copyright © 2018년 이창현. All rights reserved.
//

import Foundation
extension Double {
    
    var kmFormatted: String {
        
        if self < 1000 {
            return String(format: "%.0f", locale: Locale.current,self)
        }
        else if self >= 1000 && self <= 9999 {
            return String(format: "%.1fK", locale: Locale.current,self/1000).replacingOccurrences(of: ".0", with: "")
        }
        else if self > 9999 {
            return String(format: "%.1fM", locale: Locale.current,self/10000).replacingOccurrences(of: ".0", with: "")
        }
        return String(format: "%.0f", locale: Locale.current,self)
    }
}
