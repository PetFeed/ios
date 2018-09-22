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
    func get_all(withToken token:String,completion:@escaping (JSON)->Void) {
        print(token)
        Alamofire.request(API.base_url+"/board", method: .get, headers: ["x-access-token":token]).responseJSON { (response) in
            if let value = response.result.value,response.result.isSuccess {
                completion(JSON(value))
            }
        }
    }
    
    func get(withToken token:String,completion:@escaping (JSON)->Void) {
        Alamofire.request(API.base_url+"/user/boards", method: .get, headers: ["x-access-token":token]).responseJSON { (response) in
            if let value = response.result.value,response.result.isSuccess {
                completion(JSON(value))
            }
        }
    }
    
    func post(withToken token:String,content: String, pictures: [PHAsset],completion:@escaping (JSON)->Void) {
        
        var images:[UIImage] = []
        for i in pictures {
            
            images.append(getAssetThumbnail(asset: i, width: CGFloat(i.pixelWidth/2),height:CGFloat(i.pixelHeight/2)))
        }
        
        upload(withURL: API.base_url+"/board", token: token,content: content, imageData: images, parameters: ["hash_tags":"#asdf","contents":content]) { (json) in
            completion(json)
        }
    }
    
    private func upload(withURL: String, token:String,content: String = "", imageData: [UIImage],parameters: [String:String], completion: @escaping(JSON) -> Void) {
        
        let request = NSMutableURLRequest(url: URL(string: withURL)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue(token, forHTTPHeaderField: "x-access-token")
        //request.setValue("multipart/form-data", forHTTPHeaderField: "Content-type")
        
        
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (n,item) in imageData.enumerated() {
                if let image = UIImageJPEGRepresentation(item, 0.1) {
                    multipartFormData.append(image, withName: "pictures", fileName: "image\(n).jpeg", mimeType: "image/jpeg")
                }
            }

            multipartFormData.append("#test".data(using: .utf8)!, withName: "hash_tags")
            multipartFormData.append(content.data(using: .utf8)!, withName: "contents")

//            for (key, value) in parameters {
//                multipartFormData.append(value.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)
//            }
            
        }, with: request as! URLRequest, encodingCompletion: { (result) in
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
    
    func getAssetThumbnail(asset: PHAsset, width: CGFloat,height: CGFloat) -> UIImage {
        let retinaScale = UIScreen.main.scale
        let retinaSquare = CGSize(width: width * retinaScale, height: height * retinaScale)//(size * retinaScale, size * retinaScale)
        let cropSizeLength = min(asset.pixelWidth, asset.pixelHeight)
        let square = CGRect(x:0, y: 0,width: CGFloat(cropSizeLength),height: CGFloat(cropSizeLength))
        let cropRect = square.applying(CGAffineTransform(scaleX: 1.0/CGFloat(asset.pixelWidth), y: 1.0/CGFloat(asset.pixelHeight)))
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        var thumbnail = UIImage()
        options.isSynchronous = true
        options.deliveryMode = .highQualityFormat
        options.resizeMode = .exact
        options.normalizedCropRect = cropRect
        manager.requestImage(for: asset, targetSize: retinaSquare, contentMode: .aspectFit, options: options, resultHandler: {(result, info)->Void in
            thumbnail = result!
        })
        return thumbnail
    }
}
