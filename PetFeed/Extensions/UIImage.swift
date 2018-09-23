//
//  UIImage.swift
//  PetFeed
//
//  Created by 이창현 on 2018. 9. 23..
//  Copyright © 2018년 이창현. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func resizeUI(size:CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, true, self.scale)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }

}
