//
//  ViewController.swift
//  PetFeed
//
//  Created by 이창현 on 2018. 8. 4..
//  Copyright © 2018년 이창현. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var embeddedView: UIView!
    @IBOutlet var gestureRecognizer: UIPanGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func viewWasDragged(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: embeddedView)
        
        sender.view!.center = CGPoint(x: sender.view!.center.x , y: sender.view!.center.y + translation.y)
        
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
}

