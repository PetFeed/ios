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
    
    var frontVC: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = storyboard?.instantiateViewController(withIdentifier: "TestVC") as! SearchVC
        self.containerView.addSubview(homeVC.view)
        self.addChildViewController(homeVC)
        
        embeddedView.parentViewController = self
        
        
    }
    
    func updateFrame(_ percent:Float) {
        
        let frame = self.embeddedView.frame
        let width:CGFloat = self.view.frame.width * 0.8 + (self.view.frame.width * CGFloat(0.2 * percent))
        
        self.embeddedView.frame = CGRect(x: self.embeddedView.frame.origin.x, y: self.embeddedView.frame.origin.y, width: width, height: frame.height)
        
    }

    
}

extension BackDropVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as UICollectionViewCell
        
        cell.backgroundColor = self.randomColor()
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        
        return 4;
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        
        return 1;
    }
    
    
    //UICollectionViewDatasource methods
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    
    
    // custom function to generate a random UIColor
    func randomColor() -> UIColor{
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    
}
