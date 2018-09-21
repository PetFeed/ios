
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

struct Comment {
    var content: String
    var writer_nickname: String
    var profile_image: String
    var date: Date
}

struct Board {
    var pictures: [String]
    var comments: [Comment]
    
    var hash_tags: [String]
    
    var date:Date
    
    var likes: [String]
    
    var writer_nickname:String
    var writer_profile:String
    
    var contents: String
}

extension Board {
    static func transformUser(withJSON json:JSON) -> Board? {
        let str = json["createdate"].stringValue
        let date = Date.dateFromISOString(string: str)
        
        let board = Board(pictures: json["pictures"].arrayValue.map{$0.stringValue},
                          comments: json["comments"].arrayValue.map{
                                    Comment(content: $0["content"].stringValue,
                                            writer_nickname: $0["writer"]["user_id"].stringValue,
                                            profile_image: $0["writer"].stringValue,
                                            date: Date())} ,
                         hash_tags: json["hash_tags"].arrayValue.map{$0.stringValue},
                         date: date ?? Date(),
                         likes: json["likes"].arrayValue.map{$0.stringValue},
                         writer_nickname: json["writer"]["nickname"].stringValue,
                         writer_profile: json["writer"]["profile"].stringValue,
                         contents: json["contents"].stringValue)
        
        
        return board
    }
}


/*
 {
 "user_id" : "user1",
 "rank" : "General",
 "_id" : "5ba2de2b9ba4f23088168cd1",
 "following" : [
 
 ],
 "logs" : [
 
 ],
 "user_pw" : "$2b$10$OLYcZgg6ItICYNock0Z2.u.iF9ZTD8FTeEz5PVI1U87Zs9zdHdpbm",
 "profile" : "\/images\/default.jpg",
 "followers" : [
 
 ],
 "__v" : 0,
 "cards" : [
 
 ],
 "last_conn" : "2018-09-20T00:38:35.924Z",
 "create_date" : "2018-09-19T14:11:57.320Z",
 "nickname" : "user1"
 }
 */
