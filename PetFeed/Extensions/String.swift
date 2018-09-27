//
//  String.swift
//  PetFeed
//
//  Created by 이창현 on 2018. 8. 6..
//  Copyright © 2018년 이창현. All rights reserved.
//

import Foundation

extension String
{
    func hashtags() -> [String]
    {
        if let regex = try? NSRegularExpression(pattern: "#[a-zA-z_가-힣ㄱ-ㅎㅏ-ㅣ]+", options: .caseInsensitive)
        {
            let string = self as NSString
            
            return regex.matches(in: self, options: [], range: NSRange(location: 0, length: string.length)).map {
                string.substring(with: $0.range)
            }
        }
        
        return []
    }
}
