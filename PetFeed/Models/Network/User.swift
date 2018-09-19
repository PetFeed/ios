//
//  User.swift
//  PetFeed
//
//  Created by 이창현 on 2018. 9. 13..
//  Copyright © 2018년 이창현. All rights reserved.
//

import Foundation
import SwiftyJSON

/*
 "user": {
     "last_conn": "2018-09-13T13:59:18.075Z",
     "create_date": "2018-09-12T11:45:22.259Z",
     "rank": "General",
     "profile": "/images/default.jpg",
     "following": [],
     "followers": [],
     "cards": [],
     "logs": [],
     "_id": "5b993a3c32d6cb309c2fb133",
     "user_id": "teest",
     "user_pw": "$2b$10$V6elZQBEwJRn5zS7AcGvJ.03eJrg617rdvicYas6yVFndz5g9m5MG",
     "nickname": "teest",
     "__v": 0
 }
 */

struct User {
    var nickname: String
    var password: String
    
    var following = [""]
    var followers = [""]
    
    var id: String
    
    var cards = [""]
    
    var rank: String
    
    ///base_url + url
    var profile: String
}

extension User {
    static func transformUser(withJSON temp:JSON) -> User? {
        let json = temp["user"]
        
        let user = User(nickname: json["nickname"].stringValue,
                        password: json["user_pw"].stringValue,
                        following: json["following"].arrayValue.map{$0.stringValue},
                        followers: json["following"].arrayValue.map{$0.stringValue},
                        id: json["_id"].stringValue,
                        cards: json["cards"].arrayValue.map{$0.stringValue},
                        rank: json["rank"].stringValue,
                        profile: json["profile"].stringValue)
        
        
        return user
    }
}


