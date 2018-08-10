//
//  Array.swift
//  PetFeed
//
//  Created by 이창현 on 2018. 8. 7..
//  Copyright © 2018년 이창현. All rights reserved.
//

import Foundation

extension Array {
    func randomItem() -> Element? {
        if isEmpty { return nil }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}
