//
//  DetailVC.swift
//  PetFeed
//
//  Created by 이창현 on 2018. 9. 12..
//  Copyright © 2018년 이창현. All rights reserved.
//

import UIKit

class DetailVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var board:Board? {
        didSet {
            print(board.debugDescription)
            //tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        
        tableView.register(UINib(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.interactivePopGestureRecognizer?.delegate = self



    }
    
    override func viewDidAppear(_ animated: Bool) {
        //self.navigationController?.isNavigationBarHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 { //header
            let cell = tableView.dequeueReusableCell(withIdentifier: "header") as! DetailHeaderViewCell
            if let b = board {
                cell.info = b
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CommentCell
            cell.initialize(profile: #imageLiteral(resourceName: "content.jpeg"), name: "이창현", content: "천재", date: "1분 전")
            return cell
        }
       
        
    }
}
