//
//  direction.swift
//  PetFeed
//
//  Created by 이창현 on 2018. 8. 5..
//  Copyright © 2018년 이창현. All rights reserved.
//

enum direction {
    case up
    case down
    
    func getOpposite() -> direction {
        switch self {
        case direction.up:
            return direction.down
        case direction.down:
            return direction.up
            
        }
    }
}
