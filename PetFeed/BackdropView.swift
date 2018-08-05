//
//  BackdropView.swift
//  PetFeed
//
//  Created by 이창현 on 2018. 8. 4..
//  Copyright © 2018년 이창현. All rights reserved.
//

import UIKit

class BackdropView: UIView {
    var currentDir:direction = direction.up
    var parentViewController:BackDropVC?
    
    var parentView:UIView! {
        get {
            return parentViewController?.view!
        }
    }
    
    @IBOutlet var scrollBar: UIView!
    
    override func awakeFromNib() {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: -5)
        self.layer.shadowRadius = 1.4
        self.layer.shadowOpacity = 0.3
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.scrollBar.addGestureRecognizer(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(viewWasDragged(_:)))
        self.scrollBar.addGestureRecognizer(panGesture)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        make(parentView: parentView, dir: currentDir.getOpposite())
    }
    
    @objc func viewWasDragged(_ sender: UIPanGestureRecognizer) {
        
        let offsetY:CGFloat = 50
        
        let veloctiy = sender.velocity(in: self)
        let translation = sender.translation(in: self)
        
        self.center = CGPoint(x: self.center.x , y: self.center.y + translation.y)
        
        sender.setTranslation(CGPoint.zero, in: self)
        
        if sender.state == .ended {
            let willMoveTo:direction!
            let centerY = (parentView.frame.height - offsetY)/2 + offsetY
            
            if sender.location(in: parentView!).y < centerY {
                self.make(parentView: parentView, dir: direction.up)
            } else {
                self.make(parentView: parentView, dir: direction.down)
            }
        }
        
    }
    
}

extension BackdropView {
    func make(parentView:UIView!,dir:direction) {
        self.currentDir = dir
        UIView.animate(withDuration: 0.2) {
            self.frame = self.getSize(parentView: parentView, dir: dir)
        }
    }
    
    func getSize(parentView:UIView!,dir:direction) -> CGRect {
        let offsetY:CGFloat = 50
        
        if dir == direction.up {
            return CGRect(x: 0, y: offsetY, width: parentView.frame.width, height: parentView.frame.height)
        } else {
            return CGRect(x: 0, y: parentView.frame.height - offsetY, width: parentView.frame.width, height: parentView.frame.height)
        }
    }
}
