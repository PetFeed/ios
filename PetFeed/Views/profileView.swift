//
//  profileView.swift
//  PetFeed
//
//  Created by 이창현 on 2018. 9. 8..
//  Copyright © 2018년 이창현. All rights reserved.
//

import UIKit

class profileView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = self.frame.size.width / 2;
        self.clipsToBounds = true;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
