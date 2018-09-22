//
//  FeedCell.swift
//  PetFeed
//
//  Created by 이창현 on 2018. 8. 7..
//  Copyright © 2018년 이창현. All rights reserved.
//

import UIKit
import ImageSlideshow

class FeedCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var loveLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var imageShow: ImageSlideshow!
    
    var superViewController:UIViewController?
    
    //TODO: Make these values to board class, and make intialize function
    
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
    
    
    var content:String = "nil" {
        didSet {
            contentLabel.text = content
        }
    }
    
    var love:Int = 0 {
        didSet {
            loveLabel.text = "+\(love)"
        }
    }
    var comment:Int = 0 {
        didSet {
            commentLabel.text = "+\(comment)"
        }
    }
    
    @IBOutlet weak var commentButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageShow.pageIndicatorPosition = .init(horizontal: .center, vertical: .customUnder(padding: -30))
        imageShow.contentScaleMode = UIViewContentMode.scaleAspectFill
        
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        pageControl.pageIndicatorTintColor = UIColor.black
        imageShow.pageIndicator = pageControl
        
        // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
        imageShow.activityIndicator = DefaultActivityIndicator()
        imageShow.currentPageChanged = { page in
            //"\(API.base_url)/\()"
        }
        
        // can be used with other sample sources as `afNetworkingSource`, `alamofireSource` or `sdWebImageSource` or `kingfisherSource`
        //let localSource = [ImageSource(image: UIImage("content.jpeg")!)]

        //imageShow.setImageInputs(localSource as! [InputSource])
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(FeedCell.didTap))
        imageShow.addGestureRecognizer(recognizer)
    }
    
    @objc func didTap() {
        if let s = superViewController {
            let fullScreenController = imageShow.presentFullScreenController(from: s)
            // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
            fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
        }
        
    }
    
    func setImagesWith(source: [SDWebImageSource]) {
        imageShow.setImageInputs(source)
        let height = imageShow.slideshowItems.map{$0.frame.height}.sorted{ $0 > $1 }[0]
        heightConstraint.constant = height
    }
    
    var commentButtonHandler:(()-> Void)!
    var likeButtonHandler:(()->Void)!

    @IBAction func commentButtonPressed(_ sender: Any) {
        self.commentButtonHandler()
    }
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        self.likeButtonHandler()
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

