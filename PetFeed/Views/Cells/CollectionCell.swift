//
//  CollectionCell.swift
//  PetFeed
//
//  Created by 이창현 on 2018. 9. 14..
//  Copyright © 2018년 이창현. All rights reserved.
//

import UIKit

class CollectionCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "FeedCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: collectionView.frame.width-20, height: 500)
        }
        
        collectionView.reloadData()
    }
    
}

extension CollectionCell: UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FeedCell
        
        //cell.backgroundColor = self.randomColor()
        //cell.initalize(withBoard: )
        
        cell.commentButtonHandler = {()->Void in
            let vc = UIStoryboard(name: "Backdrop", bundle: nil).instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
            //self.navigationController?.pushViewController(vc, animated: true)
        }
        
        return cell
        
    }
}

//extension CollectionCell: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        return CGSize(width: collectionView.frame.width, height: 150)
//    }
//}
