//
//  ProfileVC.swift
//  PetFeed
//
//  Created by 이창현 on 2018. 9. 8..
//  Copyright © 2018년 이창현. All rights reserved.
//

import UIKit
import SDWebImage

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
    
    
    var items:[Board] = []
    private var refreshControl = UIRefreshControl()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        collectionView.register(UINib(nibName: "FeedCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    
        makeHeader()
        
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: view.frame.width-20, height: 500)
        }
        //collectionView.reloadData()
        
        
    }
    
    @objc func refresh() {
        self.items.removeAll()
        API.Board.get(withToken: API.currentToken) { (json) in
            json["data"].arrayValue.map{ i in
                if let d = Board.transformUser(withJSON: i) {
                    self.append(with: d)
                }
            }
            self.collectionView.reloadData()
            
        }
        self.refreshControl.endRefreshing()
        
    }
    
    func append(with item:Board) {
        self.items.append(item)
    }

    func makeHeader() {
        if API.currentUser != nil {
            refresh()
            let headerHeight:CGFloat = 195
            let headerView = UIView(frame: CGRect(x: 0,
                                                  y: -headerHeight,
                                                  width: collectionView.frame.size.width,
                                                  height: headerHeight))
            
            let profile = profileImageView(frame: CGRect(x: 16, y: 24, width: 72, height: 72))
            profile.sd_setImage(with: URL(string: API.base_url+API.currentUser.profile), placeholderImage: #imageLiteral(resourceName: "profile.jpeg"))
            profile.layer.cornerRadius = profile.frame.size.width / 2;
            profile.clipsToBounds = true;
            headerView.addSubview(profile)
            
            //let follower_num = UILabel(frame: CGRect(x: headerView.frame.width-61, y: 38, width: 45+15+10, height: 26))
            
            let follower_num = InfoNumberText(frame: CGRect(x: headerView.frame.width-61, y: 38, width: 45+15+10, height: 26), number_text: Double(API.currentUser.followers.count).kmFormatted, description_text: "팔로워")
            headerView.addSubview(follower_num.number)
            headerView.addSubview(follower_num.description)
            
            let following_num = InfoNumberText(frame: CGRect(x: headerView.frame.width-138, y: 38, width: 45+15+10, height: 26), number_text: Double(API.currentUser.following.count).kmFormatted, description_text: "팔로잉")
            headerView.addSubview(following_num.number)
            headerView.addSubview(following_num.description)
            
            let feed_num = InfoNumberText(frame: CGRect(x: headerView.frame.width-215, y: 38, width: 45+15+10, height: 26), number_text: Double(0).kmFormatted, description_text: "피드의 수")
            headerView.addSubview(feed_num.number)
            headerView.addSubview(feed_num.description)
            
            let name_label = UILabel(frame: CGRect(x: 16, y: profile.frame.origin.y+profile.frame.height+24, width: 200, height: 26))
            name_label.font = UIFont(name: "NanumSquareRoundOTFEB", size: 24)
            name_label.text = API.currentUser.nickname
            headerView.addSubview(name_label)
            
            let description_label = UILabel(frame: CGRect(x: 16, y: profile.frame.origin.y+profile.frame.height+24+4+26, width: 200, height: 13))
            description_label.font = UIFont(name: "NanumSquareRoundOTFR", size: 12)
            description_label.text = "제 나이는 9개월이고여! 말티즈에요!!"
            headerView.addSubview(description_label)
            
            
            
            collectionView.addSubview(headerView)
            collectionView.contentInset.top = headerHeight
            
            collectionView.reloadData()
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                self.makeHeader()
            })
        }
        
        
        
    }


}

extension ProfileVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FeedCell

        //cell.backgroundColor = self.randomColor()
        cell.name = items[indexPath.row].writer_nickname
        cell.profileImageView.sd_setImage(with: URL(string: "\(API.base_url)\(items[indexPath.row].writer_profile)"), completed: nil)
        cell.date = Date()
        cell.profileImage = #imageLiteral(resourceName: "profile.jpeg")
        cell.content = items[indexPath.row].contents
        cell.love = items[indexPath.row].likes.count
        cell.comment = items[indexPath.row].comments.count
        let url = URL(string: "\(API.base_url)/\(items[indexPath.row].pictures[0])")
        cell.imageView?.sd_setImage(with: url, completed: nil)
        
        
        cell.commentButtonHandler = {
            let vc = UIStoryboard(name: "Backdrop", bundle: nil).instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
            vc.board = self.items[indexPath.row]
            super.navigationController?.pushViewController(vc, animated: true)
        }
        //cell.commentButton.addTarget(self, action: #selector(ProfileVC.commentButton(cell)), for: .touchUpInside)
        return cell
    }
    


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    
    
}
