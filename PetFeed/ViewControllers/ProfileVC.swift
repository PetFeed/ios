//
//  ProfileVC.swift
//  PetFeed
//
//  Created by 이창현 on 2018. 9. 8..
//  Copyright © 2018년 이창현. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    class InfoNumberText {
        var number:UILabel
        var description:UILabel;
        
        init(frame:CGRect,number_text:String,description_text:String) {
            number = UILabel(frame: frame)
            number.text = number_text
            number.font = UIFont(name: "NanumSquareRoundOTFEB", size: 24)
            
            
            var description_frame = frame
            description_frame.origin.y += 26
            description = UILabel(frame: description_frame)
            description.text = description_text
            description.font = UIFont(name: "NanumSquareRoundOTFEB", size: 12)
            description.textColor = UIColor(red: 32/255, green: 32/255, blue: 32/255, alpha: 0.3)
        }
    }
    

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collectionView.register(UINib(nibName: "FeedCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    
        makeHeader()

        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: view.frame.width-20, height: 500)
        }
        //collectionView.reloadData()
    }
    
    

    func makeHeader() {
        
        let headerHeight:CGFloat = 195
        let headerView = UIView(frame: CGRect(x: 0,
                                              y: -headerHeight,
                                              width: collectionView.frame.size.width,
                                              height: headerHeight))
        
        let profile = profileImageView(frame: CGRect(x: 16, y: 24, width: 72, height: 72))
        profile.image = #imageLiteral(resourceName: "content.jpeg")
        profile.layer.cornerRadius = profile.frame.size.width / 2;
        profile.clipsToBounds = true;
        headerView.addSubview(profile)
        
        //let follower_num = UILabel(frame: CGRect(x: headerView.frame.width-61, y: 38, width: 45+15+10, height: 26))
       
        let follower_num = InfoNumberText(frame: CGRect(x: headerView.frame.width-61, y: 38, width: 45+15+10, height: 26), number_text: Double(333).kmFormatted, description_text: "팔로워")
        headerView.addSubview(follower_num.number)
        headerView.addSubview(follower_num.description)
        
        let following_num = InfoNumberText(frame: CGRect(x: headerView.frame.width-138, y: 38, width: 45+15+10, height: 26), number_text: Double(234).kmFormatted, description_text: "팔로잉")
        headerView.addSubview(following_num.number)
        headerView.addSubview(following_num.description)
        
        let feed_num = InfoNumberText(frame: CGRect(x: headerView.frame.width-215, y: 38, width: 45+15+10, height: 26), number_text: Double(15).kmFormatted, description_text: "피드의 수")
        headerView.addSubview(feed_num.number)
        headerView.addSubview(feed_num.description)
        
        let name_label = UILabel(frame: CGRect(x: 16, y: profile.frame.origin.y+profile.frame.height+24, width: 200, height: 26))
        name_label.font = UIFont(name: "NanumSquareRoundOTFEB", size: 24)
        name_label.text = "창현"
        headerView.addSubview(name_label)
        
        let description_label = UILabel(frame: CGRect(x: 16, y: profile.frame.origin.y+profile.frame.height+24+4+26, width: 200, height: 13))
        description_label.font = UIFont(name: "NanumSquareRoundOTFR", size: 12)
        description_label.text = "제 나이는 9개월이고여! 말티즈에요!!"
        headerView.addSubview(description_label)

        
        
        collectionView.addSubview(headerView)
        collectionView.contentInset.top = headerHeight
        
        
    }


}

extension ProfileVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FeedCell

        //cell.backgroundColor = self.randomColor()
        cell.name = "제목이다 임마"
        cell.date = Date()
        cell.profileImage = #imageLiteral(resourceName: "profile.jpeg")
        
        //cell.commentButton.addTarget(self, action: #selector(ProfileVC.commentButton(cell)), for: .touchUpInside)
        return cell
    }
    
//    @objc func commentButton(_ sender: FeedCell) {
//        let vc = UIStoryboard(name: "BackDrop", bundle: nil).instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
//        present(vc, animated: true, completion: nil)
//    }



    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    
    
}
