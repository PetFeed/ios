//
//  BoardAPI.swift
//  PetFeed
//
//  Created by 이창현 on 2018. 9. 19..
//  Copyright © 2018년 이창현. All rights reserved.
//

import Foundation
import UIKit
import Photos
import SwiftyJSON
import Alamofire


class BoardAPI {
    func delete(withID id:String,token:String,completion:@escaping (JSON)->Void) {
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
            "x-access-token": token
        ]
        
        let parameters = [
            "board_id":id
        ]
        //print(parameters)
        Alamofire.request("\(API.base_url)/board/",method:.delete,parameters:parameters,encoding:URLEncoding.httpBody,headers:headers)
            .responseJSON(completionHandler: { (response) in
                //1. JSON 변환
                if let value = response.result.value,response.result.isSuccess {
                    completion(JSON(value))
                }
            })
    }
    
    func get_all(withToken token:String,completion:@escaping (JSON)->Void) {
        print(token)
        Alamofire.request(API.base_url+"/board", method: .get, headers: ["x-access-token":token]).responseJSON { (response) in
            if let value = response.result.value,response.result.isSuccess {
                completion(JSON(value))
            }
        }
    }
    
    func get(withID id:String, token:String, completion:@escaping (JSON)-> Void) {
        Alamofire.request(API.base_url+"/board/\(id)", method: .get, headers: ["x-access-token":token]).responseJSON { (response) in
            if let value = response.result.value,response.result.isSuccess {
                completion(JSON(value))
            }
        }
    }
    
    func getUserBoards(withToken token:String,completion:@escaping (JSON)->Void) {
        Alamofire.request(API.base_url+"/user/boards", method: .get, headers: ["x-access-token":token]).responseJSON { (response) in
            if let value = response.result.value,response.result.isSuccess {
                completion(JSON(value))
            }
        }
    }
    
    func post(withToken token:String,content: String, pictures: [PHAsset],completion:@escaping (JSON)->Void) {
        
        let images:[UIImage] = pictures.map{getThumbnail(asset: $0) ?? #imageLiteral(resourceName: "image-picker-camera.pdf")}
        
        let a = content.hashtags()
        
        upload(withURL: API.base_url+"/board", token: token,content: content,hashtags:a, imageData: images) { (json) in
            completion(json)
        }
    }
    
    func like(withToken token:String,toBoardID id:String,completion:@escaping (JSON)->Void) {
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
            "x-access-token": token
        ]
        let parameters = [
            "board_id":id
        ]
        //print(parameters)
        Alamofire.request("\(API.base_url)/board/like",method:.post,parameters:parameters,encoding:URLEncoding.httpBody,headers:headers)
            .responseJSON(completionHandler: { (response) in
                //1. JSON 변환
                if let value = response.result.value,response.result.isSuccess {
                    completion(JSON(value))
                }
            })
    }
    
    private func upload(withURL: String, token:String,content: String = "",hashtags:[String], imageData: [UIImage], completion: @escaping(JSON) -> Void) {
        
        let request = NSMutableURLRequest(url: URL(string: withURL)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue(token, forHTTPHeaderField: "x-access-token")
        //request.setValue("multipart/form-data", forHTTPHeaderField: "Content-type")
        
        
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (n,item) in imageData.enumerated() {
                if let image = UIImageJPEGRepresentation(item, 0.5) {
                    multipartFormData.append(image, withName: "pictures", fileName: "image\(n).jpeg", mimeType: "image/jpeg")
                }
            }

            for value in hashtags {
                multipartFormData.append(value.data(using: String.Encoding.utf8)! , withName: "hash_tags[]", mimeType:"text/plain")
            }
            
            multipartFormData.append(content.data(using: .utf8)!, withName: "contents")
         
//            for (key, value) in parameters {
//                multipartFormData.append(value.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)
//            }
            
        }, with: request as URLRequest, encodingCompletion: { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    //debugPrint(response)
                    let data = JSON(response.result.value)
                    
                    //print(data)
                    completion(data)
                    
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                
            }
            
        })
        
        
        
    }
    
    func comment(withToken token:String, parent: String, content:String, type:String,completion:@escaping (JSON)-> Void) {
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
            "x-access-token": token
        ]
        let parameters = [
            "parent":parent,
            "content":content,
            "type":type
        ]
        //print(parameters)
        Alamofire.request("\(API.base_url)/comment",method:.post,parameters:parameters,encoding:URLEncoding.httpBody,headers:headers)
            .responseJSON(completionHandler: { (response) in
                //1. JSON 변환
                if let value = response.result.value,response.result.isSuccess {
                    completion(JSON(value))
                }
            })
    }
    
    func getThumbnail(asset: PHAsset) -> UIImage? {
        
        var thumbnail: UIImage?
        
        let manager = PHImageManager.default()
        
        let options = PHImageRequestOptions()
        
        options.version = .original
        options.isSynchronous = true
        
        manager.requestImageData(for: asset, options: options) { data, _, _, _ in
            
            if let data = data {
                thumbnail = UIImage(data: data)
            }
        }
        
        return thumbnail
    }
    
    
}
