//
//  FeedCell.swift
//  PetFeed
//
//  Created by 이창현 on 2018. 8. 7..
//  Copyright © 2018년 이창현. All rights reserved.
//

import UIKit

class FeedCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    var profileImage:UIImage! {
        didSet {
            profileImageView.image = profileImage
        }
    }
    
    var name:String = "이창현" {
        didSet {
            nameLabel.text = name
        }
    }
    
    var date:Date = Date() {
        didSet {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy.MM.dd"
            let result = formatter.string(from: date)

            dateLabel.text = result
        }
    }
    
    var image:UIImage! {
        didSet {
            imageView.image = #imageLiteral(resourceName: "profile.jpg")
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        
        
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        
        return layoutAttributes
        
    }
}
