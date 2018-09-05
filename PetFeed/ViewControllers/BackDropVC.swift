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
        
        collectionView.register(UINib(nibName: "FeedCell", bundle: nil), forCellWithReuseIdentifier: "cell")

        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: embeddedViewWidth.constant-20, height: 100)
        }
        
        
        let _storyboard: UIStoryboard = UIStoryboard(name: "Search", bundle: nil)
        
        let homeVC = _storyboard.instantiateInitialViewController() as! SearchVC
        self.containerView.addSubview(homeVC.view)
        self.addChildViewController(homeVC)
        
        embeddedView.parentViewController = self
        embeddedView.originalFrame = self.view.frame
    }
    
    func updateFrame(_ width:CGFloat) {
        embeddedViewWidth.constant = width
        embeddedView.scrollBar.roundCorners([.topLeft,.topRight], radius: 20)
    }
    
    
}

extension BackDropVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FeedCell
        
        //cell.backgroundColor = self.randomColor()
        cell.name = titleText
        cell.date = Date()
        cell.profileImage = #imageLiteral(resourceName: "profile.jpeg")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 400)
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    
    
    // custom function to generate a random UIColor
    func randomColor() -> UIColor{
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    
}
