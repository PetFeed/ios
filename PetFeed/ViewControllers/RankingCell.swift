//
//  RankingCollectionViewCell.swift
//  PetFeed
//
//  Created by 이창현 on 2018. 8. 6..
//  Copyright © 2018년 이창현. All rights reserved.
//

import UIKit

class RankingCell: UICollectionViewCell {
    
    @IBOutlet weak var textLabel: UILabel!
    var title:String! {
        didSet {
            textLabel.text = "#"+title
        }
    }
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 68/255, green: 45/255, blue: 38/255, alpha: 1).cgColor
    }
}
