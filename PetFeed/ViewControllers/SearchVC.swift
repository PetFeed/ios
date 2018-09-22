//
//  TestVC.swift
//  PetFeed
//
//  Created by 이창현 on 2018. 8. 5..
//  Copyright © 2018년 이창현. All rights reserved.
//

import UIKit
import ImageSlideshow

class SearchVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var rankingCollectionView: UICollectionView!
    
    @IBOutlet weak var searchField: UITextField!
    
    let items = ["샤트룩스","골든 리트리버","코카투","치와와","말티즈","미니어쳐 핀셔","파피용","포메라니안","푸들","시추"]

    //self.myCollectionView.collectionViewLayout.collectionViewContentSize.height
    
    override func viewDidLoad() {
        tableView.estimatedRowHeight = UITableViewAutomaticDimension;
        tableView.rowHeight = UITableViewAutomaticDimension
        rankingCollectionView.register(UINib(nibName: "HashTagCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "cell")!
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CollectionCell
            return cell.collectionView.collectionViewLayout.collectionViewContentSize.height
        } else {
            return UITableViewAutomaticDimension
        }
    }
}

extension SearchVC:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 128, height: 144)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HashTagCell
        
        cell.title = items[indexPath.row]
        cell.image = #imageLiteral(resourceName: "profile.jpeg")
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searchField.text = items[indexPath.row]
        searchField.resignFirstResponder()
        
        if let backdrop = parent as? BackDropVC {
            backdrop.titleText = items[indexPath.row]
            backdrop.embeddedView.make(parentView: backdrop.view, dir: direction.up)
        }

    }
}
