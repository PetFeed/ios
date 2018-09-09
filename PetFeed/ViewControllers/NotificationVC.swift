//
//  NotificationVC.swift
//  PetFeed
//
//  Created by 이창현 on 2018. 9. 7..
//  Copyright © 2018년 이창현. All rights reserved.
//

import UIKit

class NotificationVC: UITableViewController {

    @IBOutlet var myTableView: UITableView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //myTableView.register(UINib(nibName: "NotificationCell", bundle: nil), forCellReuseIdentifier: "cell")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
//
//        return cell!
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
    
    
}
