//
//  TestVC.swift
//  PetFeed
//
//  Created by 이창현 on 2018. 8. 5..
//  Copyright © 2018년 이창현. All rights reserved.
//

import UIKit

class SearchVC: UIViewController,UITextViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let items = ["샤트룩스","골든 리트리버","코카투","치와와","말티즈","미니어쳐 핀셔","파피용","포메라니안","푸들","시추"]
    
    //var rankingCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear
        
        //collectionView.register(UINib(nibName: "HashTagCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        

        collectionView.register(UINib(nibName: "FeedCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        makeHeader()
        
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: view.frame.width-20, height: 500)
        }
    }
    func makeHeader() {
        
        let headerHeight:CGFloat = 531
        var cWidth:CGFloat { return collectionView.frame.width }
        var cHeight:CGFloat { return collectionView.frame.height }
        
        let headerView = UIView(frame: CGRect(x: 0,
                                              y: -headerHeight,
                                              width: cWidth,
                                              height: headerHeight))
        
        let searchField = UITextField(frame: CGRect(x: 16, y: 16, width: cWidth-16, height: 52))
        searchField.backgroundColor = UIColor.brown
        searchField.layoutIfNeeded()
//        searchField.layer.shadowOffset = CGSize(width: 5, height: 5)
//        searchField.layer.shadowColor = UIColor.gray.cgColor
//        searchField.layer.shadowOpacity = 0.5
//        searchField.layer.shadowRadius = 1.4
        headerView.addSubview(searchField)
        
        let title_text1 = UILabel(frame: CGRect(x: 16, y: getYFrom(frame: searchField.frame, offset: 32), width: 159, height: 26))
        title_text1.text = "트렌드 해시태그"
        title_text1.font = UIFont(name: "NanumSquareRoundOTFEB", size: 24)
        headerView.addSubview(title_text1)
        
//        rankingCollectionView = UICollectionView(frame: CGRect(x: 16, y: getYFrom(frame: title_text1.frame, offset: 16), width: cWidth-16, height: 144))
//        rankingCollectionView.delegate = self
//        rankingCollectionView.dataSource = self
//        rankingCollectionView.register(UINib(nibName: "HashTagCell", bundle: nil), forCellWithReuseIdentifier: "cell")
//
//        headerView.addSubview(rankingCollectionView)
        
        
        collectionView.addSubview(headerView)
        collectionView.contentInset.top = headerHeight
        
        
    }
    
    func getYFrom(frame:CGRect,offset:CGFloat) -> CGFloat {
        return frame.origin.y+frame.height+offset
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    }
}
