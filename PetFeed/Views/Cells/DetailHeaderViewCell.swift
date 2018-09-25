//
//  DetailHeaderViewCell.swift
//  PetFeed
//
//  Created by 이창현 on 2018. 9. 20..
//  Copyright © 2018년 이창현. All rights reserved.
//

import UIKit
import ImageSlideshow

class DetailHeaderViewCell: UITableViewCell {
    @IBOutlet weak var profileImageView: profileImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var imageShow: ImageSlideshow!
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    var info:Board? {
        
        didSet {
            if let i = info {
                if i
                    .likes.contains(API.currentUser.id ) {
                    likeButton.setImage(UIImage(named: "favorite"), for: .normal)
                } else{
                    likeButton.setImage(UIImage(named: "favorite_empty"), for: .normal)
                }
                
                commentLabel.text = "+\(i.comments.count)"
                likeLabel.text = "+\(i.likes.count)"
                
                contentLabel.text = i.contents
                
//                if i.pictures.count > 0 {
//                    let url = URL(string: "\(API.base_url)/\(i.pictures[0])")
//                    contentImageView.sd_setImage(with: url, completed: nil)
//                }
                
                
                
                profileImageView.sd_setImage(with: URL(string: "\(API.base_url)\(i.writer_profile)"), completed: nil)
                
                nameLabel.text = i.writer_nickname
                
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy.MM.dd"
                let result = formatter.string(from: i.date)
                dateLabel.text = result
            }
           
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
