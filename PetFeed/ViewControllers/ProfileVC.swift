//
//  ProfileVC.swift
//  PetFeed
//
//  Created by 이창현 on 2018. 9. 8..
//  Copyright © 2018년 이창현. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collectionView.register(UINib(nibName: "FeedCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    
        let headerHeight:CGFloat = 195
        let headerView = UIView(frame: CGRect(x: 0,
                                              y: -headerHeight,
                                              width: collectionView.frame.size.width,
                                              height: headerHeight))
        
        let profile = profileImageView(frame: CGRect(x: 24, y: 16, width: 72, height: 72))
        profile.image = #imageLiteral(resourceName: "content.jpeg")
        profile.layer.cornerRadius = profile.frame.size.width / 2;
        profile.clipsToBounds = true;
        headerView.addSubview(profile)
        collectionView.addSubview(headerView)
        collectionView.contentInset.top = headerHeight
        

        print("I got it baby")
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: view.frame.width-20, height: 500)
        }
        //collectionView.reloadData()
    }



}

extension ProfileVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FeedCell

        //cell.backgroundColor = self.randomColor()
        cell.name = "제목이다 임마"
        cell.date = Date()
        cell.profileImage = #imageLiteral(resourceName: "profile.jpeg")
        return cell
    }




    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    
    
}
