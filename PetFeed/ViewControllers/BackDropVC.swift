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
    
    @IBOutlet weak var marketBtn: UIButton!
    
    @IBOutlet weak var profileBtn: UIButton!
    
    var titleText:String = "Hello" {
        didSet {
            collectionView.reloadData()
            
            
        }
    }
    
    let btnMinOpacity:Float = 0.3
    var tabs:[UIButton] = []
    var currentIndex = 0 {
        didSet {
            tabAction(withIndex: currentIndex)
        }
    }
    
    var tabViewControllers:[UIViewController] = []
    
    private lazy var searchVC:SearchVC = {
        let storyboard: UIStoryboard = UIStoryboard(name: "Tabs", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchVC") as! SearchVC
        return vc
    }()
    
    private lazy var notificationVC:NotificationVC = {
        let storyboard: UIStoryboard = UIStoryboard(name: "Tabs", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "NotificationVC")as! NotificationVC
        return vc
    }()
    
    private lazy var writeVC:WriteVC = {
        let storyboard: UIStoryboard = UIStoryboard(name: "Tabs", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "WriteVC")as! WriteVC
        return vc
    }()
    
    private lazy var marketVC:MarketVC = {
        let storyboard: UIStoryboard = UIStoryboard(name: "Tabs", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "MarketVC") as! MarketVC
        return vc
    }()
    
    private lazy var profileVC:ProfileVC = {
        let storyboard: UIStoryboard = UIStoryboard(name: "Tabs", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        return vc
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabInit()
        
        collectionView.register(UINib(nibName: "FeedCell", bundle: nil), forCellWithReuseIdentifier: "cell")

        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: embeddedViewWidth.constant-20, height: 100)
        }
        
        embeddedView.parentViewController = self
        embeddedView.originalFrame = self.view.frame
    }
    
    func tabInit() {
        tabs = [searchBtn,notificationBtn,writeBtn,marketBtn,profileBtn]
        tabs.forEach { (element) in
            if (element == tabs[2] || element == tabs[currentIndex]) {
                element.layer.opacity = 1
            } else {
                element.layer.opacity = btnMinOpacity
            }
        }
        tabViewControllers = [searchVC,notificationVC,writeVC,marketVC,profileVC]
        
        for i in tabViewControllers {
            if i != writeVC {
                add(asChildViewController: i)
            }
        }
        change(toViewController: searchVC)
    }
    
    func tabPressed(_ sender: UIButton) {
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
    
    func tabAction(withIndex index:Int) {
        let willTurnto = tabViewControllers[index]
        if willTurnto == writeVC {
            let storyboard: UIStoryboard = UIStoryboard(name: "Tabs", bundle: nil)
            
            let vc = storyboard.instantiateViewController(withIdentifier: "WriteVC")as! WriteVC
            self.present(vc, animated: true, completion: nil)
            
        } else {
            change(toViewController: willTurnto)
        }
    }
    
    @IBAction func tabBarBtnPressed(_ sender: UIButton) {
        tabPressed(sender)
        
        embeddedView.make(parentView: self.view, dir: .down)
    }
    
    
}

extension BackDropVC {
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChildViewController(viewController)
        
        // Add Child View as Subview
        self.containerView.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = self.containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.view.isHidden = true
        
        // Notify Child View Controller
        viewController.didMove(toParentViewController: self)
    }
    
    private func change(toViewController vc:UIViewController) {
        for i in tabViewControllers {
            remove(with: i)
        }
        vc.view.isHidden = false
    }
    
    private func remove(with vc:UIViewController) {
        // Notify Child View Controller
        vc.willMove(toParentViewController: nil)
        
        // Remove Child View From Superview
        ///viewController.view.removeFromSuperview()
        vc.view.isHidden = true
        
        // Notify Child View Controller
        //viewController.removeFromParentViewController()
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

