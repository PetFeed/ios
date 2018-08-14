//
//  BackDropVC.swift
//  PetFeed
//
//  Created by 이창현 on 2018. 8. 5..
//  Copyright © 2018년 이창현. All rights reserved.
//

import UIKit

class BackDropVC: UIViewController {

    @IBOutlet weak var embeddedView: BackdropView!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var embeddedViewWidth: NSLayoutConstraint!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var titleText:String = "Hello" {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        embeddedViewWidth.constant = self.view.frame.width

        collectionView.register(UINib(nibName: "FeedCell", bundle: nil), forCellWithReuseIdentifier: "cell")
//
//        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            flowLayout.estimatedItemSize = CGSize(width: 325, height: 1)
//        }
        
        let _storyboard: UIStoryboard = UIStoryboard(name: "Search", bundle: nil)
        
        let homeVC = _storyboard.instantiateInitialViewController() as! SearchVC
        self.containerView.addSubview(homeVC.view)
        self.addChildViewController(homeVC)
        
        embeddedView.parentViewController = self
    }
    
    func updateFrame(_ width:CGFloat) {
        embeddedViewWidth.constant = width
        embeddedView.scrollBar.roundCorners([.topLeft,.topRight], radius: 20)
        embeddedView.layoutIfNeeded()
    }
    
    
}

extension BackDropVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FeedCell
        
        //cell.backgroundColor = self.randomColor()
        cell.name = titleText
        cell.date = Date()
        cell.profileImage = #imageLiteral(resourceName: "profile.jpg")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    
    
    // custom function to generate a random UIColor
    func randomColor() -> UIColor{
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    
}
