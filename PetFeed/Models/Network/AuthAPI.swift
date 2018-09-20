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
import Firebase

class AuthAPI {
    
    func login( parameters:[String:String],completion:@escaping (JSON)->Void) {
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        
        Alamofire.request("\(API.base_url)/auth/login",method:.post,parameters:parameters,encoding:URLEncoding.httpBody,headers:headers)
            .responseJSON(completionHandler: { (response) in
                //1. JSON 변환
                if let value = response.result.value,response.result.isSuccess {
                    completion(JSON(value))
                    
                }
            })
    }
    
    func patch(withToken token: String,parameters:[String:String],completion:@escaping (JSON)->Void) {
        
        let headers: HTTPHeaders = [
            "x-access-token": token
        ]
        
        Alamofire.request("\(API.base_url)/auth/login",method:.patch,parameters:parameters,encoding:URLEncoding.httpBody,headers:headers)
            .responseJSON(completionHandler: { (response) in
                //1. JSON 변환
                if let value = response.result.value,response.result.isSuccess {
                    completion(JSON(value))
                }
            })
    }
    
    func fetch_user(withToken token:String,completion:@escaping (JSON)->Void) {
        Alamofire.request(API.base_url+"/user/", method: .get, headers: ["x-access-token":token]).responseJSON { (response) in
            if let value = response.result.value,response.result.isSuccess {
                completion(JSON(value))
            }
        }
    }
    
    func register( id: String, password: String, nickname: String = "닉네임",completion:@escaping (JSON)->Void) {
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        let parameters = [
            "user_id": id,
            "user_pw": password,
            "nickname": nickname,
            "fcm_token": Messaging.messaging().fcmToken ?? ""
        ]
        print(parameters)
        Alamofire.request("\(API.base_url)/auth/register",method:.post,parameters:parameters,encoding:URLEncoding.httpBody,headers:headers)
            .responseJSON(completionHandler: { (response) in
                //1. JSON 변환
                if let value = response.result.value,response.result.isSuccess {
                    completion(JSON(value))
                }
            })
    }
    
}
