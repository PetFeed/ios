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
    
    
    @IBOutlet weak var searchBtn: UIButton!
    
    @IBOutlet weak var notificationBtn: UIButton!
    
    @IBOutlet weak var writeBtn: UIButton!
    
    @IBOutlet weak var storeBtn: UIButton!
    
    @IBOutlet weak var profileBtn: UIButton!
    
    let btnMinOpacity:Float = 0.3
    var tabs:[UIButton] = []
    var currentIndex = 0
    
    
    var titleText:String = "Hello" {
        didSet {
            collectionView.reloadData()
            
            
        }
    }
    
    
    private lazy var searchVC:SearchVC = {
        let storyboard: UIStoryboard = UIStoryboard(name: "Search", bundle: nil)
        
        let searchVC = storyboard.instantiateInitialViewController() as! SearchVC
        self.containerView.addSubview(searchVC.view)
        self.addChildViewController(searchVC)
        
        return searchVC
    }()
    
    private lazy var notificationVC:NotificationVC = {
        let storyboard: UIStoryboard = UIStoryboard(name: "Notification", bundle: nil)
        
        let notificationVC = storyboard.instantiateInitialViewController() as! NotificationVC
        self.containerView.addSubview(notificationVC.view)
        self.addChildViewController(notificationVC)
        
        return notificationVC
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabs = [searchBtn,notificationBtn,writeBtn,storeBtn,profileBtn]
        tabs.forEach { (element) in
            if (element == tabs[2] || element == tabs[currentIndex]) {
                element.layer.opacity = 1
            } else {
                element.layer.opacity = btnMinOpacity
            }
        }
        
        collectionView.register(UINib(nibName: "FeedCell", bundle: nil), forCellWithReuseIdentifier: "cell")

        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: embeddedViewWidth.constant-20, height: 100)
        }
        
        
        add(asChildViewController: searchVC)
        
        embeddedView.parentViewController = self
        embeddedView.originalFrame = self.view.frame
    }
    
    func updateFrame(_ width:CGFloat) {
        embeddedView.scrollBar.roundCorners([.topLeft,.topRight], radius: 20)
    }
    
    func tabAction(_ sender: UIButton) {
        for (n,i) in tabs.enumerated() {
            if (i == sender) {
                currentIndex = n
            }
            if (i == sender || i == tabs[2]) {
                sender.layer.opacity = 1
            } else {
                i.layer.opacity = btnMinOpacity
            }
        }
        
    }
    
    @IBAction func tabBarBtnPressed(_ sender: UIButton) {
        tabAction(sender)
        embeddedView.make(parentView: self.view, dir: .down)
        
        switch currentIndex {
        case 0:
            remove(asChildViewController: notificationVC)
            add(asChildViewController: searchVC)
            break;
        case 1:
            remove(asChildViewController: searchVC)
            add(asChildViewController: notificationVC)
            break;
        default:
            break;
        }
    }
    
    
}

extension BackDropVC {
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChildViewController(viewController)
        
        // Add Child View as Subview
        self.containerView.addSubview(viewController.view)
        
        // Configure Child View
        //viewController.view.frame = view.bounds
        //viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        //viewController.didMove(toParentViewController: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        //viewController.willMove(toParentViewController: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParentViewController()
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
        return CGSize(width: self.view.frame.width-20, height: 400)
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

