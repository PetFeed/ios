//
//  TestVC.swift
//  PetFeed
//
//  Created by 이창현 on 2018. 8. 5..
//  Copyright © 2018년 이창현. All rights reserved.
//

import UIKit

class SearchVC: UIViewController,UITextViewDelegate {
    
    @IBOutlet weak var searchField: UITextField!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    let items = ["샤트룩스","골든 리트리버","코카투","치와와","말티즈","미니어쳐 핀셔","파피용","포메라니안","푸들","시추"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear
        
        collectionView.register(UINib(nibName: "HashTagCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        searchField.layer.shadowOffset = CGSize(width: 5, height: 5)
        searchField.layer.shadowColor = UIColor.gray.cgColor
        searchField.layer.shadowOpacity = 0.5
        searchField.layer.shadowRadius = 1.4
        //view.backgroundColor = UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0)
        
//        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
//        }
        
    }

}

extension SearchVC: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
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
