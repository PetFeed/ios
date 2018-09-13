//
//  API.swift
//  PetFeed
//
//  Created by 이창현 on 2018. 9. 13..
//  Copyright © 2018년 이창현. All rights reserved.
//

import Foundation

class API {
    static var base_url = "api.petfeed.app"
    static var Auth = AuthAPI()
    static var currentUser:User? = nil
    static var currentToken:String = ""
}
