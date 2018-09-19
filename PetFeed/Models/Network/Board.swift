
//
//  Board.swift
//  PetFeed
//
//  Created by 이창현 on 2018. 9. 19..
//  Copyright © 2018년 이창현. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
/*
 "data": {
 "createdate": "2018-09-18T15:43:27.465Z",
 "pictures": [
 "/home/dudco/api-server/public/boards/5b993a3c32d6cb309c2fb133/5ba21bd1a50b1d5a7782189f/image.jpeg"
 ],
 "comments": [],
 "hash_tags": [
 "#test"
 ],
 "likes": [],
 "_id": "5ba21bd1a50b1d5a7782189f",
 "contents": "",
 "writer": "5b993a3c32d6cb309c2fb133",
 "__v": 0
 }
 */

struct Board {
    var pictures: [String]
    var comments: [String]
    
    var hash_tags: [String]
    
    var likes: [String]
    
    var writer:String
    
    var contents: String
}

extension Board {
    static func transformUser(withJSON json:JSON) -> Board? {
        
        let board = Board(pictures: json["pictures"].arrayValue.map{$0.stringValue},
                         comments: json["comments"].arrayValue.map{$0.stringValue},
                         hash_tags: json["hash_tags"].arrayValue.map{$0.stringValue},
                         likes: json["likes"].arrayValue.map{$0.stringValue},
                         writer: json["writer"].stringValue,
                         contents: json["contents"].stringValue)
        
        print("I made a board about \(board.contents)")
        return board
    }
}


