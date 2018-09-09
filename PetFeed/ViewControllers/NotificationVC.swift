//
//  NotificationVC.swift
//  PetFeed
//
//  Created by 이창현 on 2018. 9. 7..
//  Copyright © 2018년 이창현. All rights reserved.
//

import UIKit

class NotificationVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var myTableView: UITableView!
    
    let oldItems = ["오래된 알림1"]
    let newItems = ["새로운 알림1","새로운 알림2"]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        myTableView.register(UINib(nibName: "NotificationCell", bundle: nil), forCellReuseIdentifier: "cell")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "새 알림"
        } else {
            return "이전 알림"
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? NotificationCell {
            if indexPath.section == 0 {
                cell.titleLabel.text = newItems[indexPath.row]
            } else {
                cell.titleLabel.text = oldItems[indexPath.row]
            }
            return cell
        } else {
            let cell = NotificationCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
            if indexPath.section == 0 {
                cell.titleLabel.text = newItems[indexPath.row]
            } else {
                cell.titleLabel.text = oldItems[indexPath.row]
            }
            return cell
        }
        
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return newItems.count
        } else {
            return oldItems.count
        }
    }
    
    
}
