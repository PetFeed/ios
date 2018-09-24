//
//  BackDropVC.swift
//  PetFeed
//
//  Created by 이창현 on 2018. 8. 5..
//  Copyright © 2018년 이창현. All rights reserved.
//

import UIKit
import ImageSlideshow

class BackDropVC: UIViewController {
    
    var items:[Board] = []
    var refreshControl = UIRefreshControl()

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
        refresh()

        collectionView.register(UINib(nibName: "FeedCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)

        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: embeddedView.frame.width-20, height: 500)
        }
        
        embeddedView.parentViewController = self
        embeddedView.originalFrame = self.view.frame
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
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
            if (i != tabs[2]) {
                if (i == sender ) {
                    sender.layer.opacity = 1
                } else {
                    i.layer.opacity = btnMinOpacity
                }
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
        
        if items.count > 0 {
            cell.initalize(withBoard: items[indexPath.row])
            
            cell.superViewController = self
            
            cell.commentButtonHandler = {
                let vc = UIStoryboard(name: "Backdrop", bundle: nil).instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
                vc.board = self.items[indexPath.row]
                vc.temp_images = cell.imageShow.images
                
                super.navigationController?.pushViewController(vc, animated: true)
            }
            
            cell.likeButtonHandler = {
                API.Board.like(withToken: API.currentToken, toBoardID: self.items[indexPath.row].id, completion: { (json) in
                    self.refreshWithid(id: self.items[indexPath.row].id)
                })
            }
        }
        return cell
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func refreshWithid(id: String) {
        API.Board.get(withID: id, token: API.currentToken) { (json) in
            if json["success"].boolValue == true {
                
                if let index = self.items.index(where: {$0.id == id}),
                    let boardData = Board.transformUser(withJSON: json["data"]) {
                    self.items[index] = boardData
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    @objc func refresh() {
        self.items.removeAll()
        API.Board.get_all(withToken: API.currentToken) { (json) in
            json["data"].arrayValue.map{ i in
                if let d = Board.transformUser(withJSON: i) {
                    self.append(with: d)
                }
            }
            self.collectionView.reloadData()
            
        }
        self.refreshControl.endRefreshing()
        
    }
    
    func append(with item:Board) {
        self.items.append(item)
    }
    
    // custom function to generate a random UIColor
    func randomColor() -> UIColor{
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    
}

