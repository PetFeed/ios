//
//  RankingCollectionViewCell.swift
//  PetFeed
//
//  Created by 이창현 on 2018. 8. 6..
//  Copyright © 2018년 이창현. All rights reserved.
//

import UIKit

class HashTagCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var fromLabel: UILabel!
    
    @IBOutlet weak var gradientView: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var title:String! {
        didSet {
            titleLabel.text = "#"+title
        }
    }
    
    var image:UIImage! {
        didSet {
            imageView.image = image
        }
    }
    
    var from:String! {
        didSet {
            fromLabel.text = "Photoed by "+from
        }
    }
    
    
    override func awakeFromNib() {

        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 1.4
        self.layer.masksToBounds = false
        
        
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor,UIColor.black.cgColor]
        gradientLayer.locations = [0.0, 1.3]
        gradientLayer.frame = gradientView.bounds
        gradientView.layer.insertSublayer(gradientLayer, at: 0)
    }
}
