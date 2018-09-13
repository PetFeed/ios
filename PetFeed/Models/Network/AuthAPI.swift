//
//  AuthAPI.swift
//  PetFeed
//
//  Created by 이창현 on 2018. 9. 13..
//  Copyright © 2018년 이창현. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthAPI {
    
    func login( id: String, password: String,completion:@escaping (JSON)->Void) {
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        let parameters = [
            "user_id": id,
            "user_pw": password
        ]
        Alamofire.request("\(API.base_url)/auth/login",method:.post,parameters:parameters,encoding:URLEncoding.httpBody,headers:headers)
            .responseJSON(completionHandler: { (response) in

                //1. JSON 변환
                if let value = response.result.value,response.result.isSuccess {
                    completion(JSON(value))
                }
            })
    }
    
}
