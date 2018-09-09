//
//  profileView.swift
//  PetFeed
//
//  Created by 이창현 on 2018. 9. 8..
//  Copyright © 2018년 이창현. All rights reserved.
//

import UIKit

class profileImageView: UIImageView {
    
    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.size.width / 2;
        self.clipsToBounds = true;
    }
    
    
}
