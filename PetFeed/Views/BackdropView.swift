//
//  BackdropView.swift
//  PetFeed
//
//  Created by 이창현 on 2018. 8. 4..
//  Copyright © 2018년 이창현. All rights reserved.
//

import UIKit
import Foundation

class BackdropView: UIView {
    
    //MARK: 상수
    let opacity_min:Float = 0
    let opacity_max:Float = 1
    
    let offset_top_y:CGFloat = 44
    var offset_bottom_y:CGFloat {
        return scrollBar.frame.height + 86 //+(self.parentViewController?.tabBarController?.tabBar.frame.height)!
    }
    
    var tabbar_height: CGFloat {
        return (self.parentViewController?.tabBarController?.tabBar.frame.height)!
    }
    
    //바텀바 드래그해서 올릴때 감도(?) 조절
    let bottomBar_scroll_height:CGFloat = 80
    let bottomBar_min_size:CGFloat = 0.85
    
    //MARK: 변수
    var currentDir:direction = direction.up
    var parentViewController:BackDropVC?
    
    var parentView:UIView! {
        return parentViewController?.view!
    }
    
    //얼마나 움직였는지
    var moved:CGFloat = 0.0
    
    //얼마나 움직였는지를 퍼센트로 (0.0 ~ 1.0)
    var percent:Float = 0.0 {
        didSet {
            let col=UIColor.white.toColor(UIColor.camoGreen, percentage: CGFloat(percent*100))
            let col2=UIColor.camoGreen.toColor(UIColor.white, percentage: CGFloat(percent*100))

            
            //SetOpacity
            self.parentView.backgroundColor = col
            
            self.opacityView.backgroundColor = col2
            self.opacityView.layer.opacity = 1-percent
            
            //print(percent)
            
            self.parentViewController?.collectionView.layer.opacity = percent
            //self.scrollBar.layer.opacity = percent

            //parentViewController?.updateFrame(percent)
//            let width:CGFloat = self.originalFrame.width * bottomBar_min_size
//                                + (self.originalFrame.width * CGFloat(1-bottomBar_min_size)
//                                * CGFloat(percent))

            //self.parentViewController?.updateFrame(width)
            
        }
    }
    
    //눌러서 움직일 수 있는 바
    @IBOutlet var scrollBar:UIView!
    @IBOutlet var opacityView:UIView!
    
    //기본값
    var originalFrame:CGRect!
    
    override func awakeFromNib() {
        
        
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: -5)
        self.layer.shadowRadius = 1.4
        self.layer.shadowOpacity = 0.3
        
        //위에만 둥글게
        self.roundCorners([.topLeft,.topRight], radius: 20)
        
        //self.backgroundColor = UIColor(hexString: "442d26")
        self.backgroundColor = UIColor.white
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.scrollBar.addGestureRecognizer(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(viewWasDragged(_:)))
        self.scrollBar.addGestureRecognizer(panGesture)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        make(parentView: parentView, dir: currentDir.getOpposite())
    }
    
    
    
    @objc func viewWasDragged(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self)
        
        self.center = CGPoint(x: self.center.x , y: self.center.y + translation.y)
        
        sender.setTranslation(CGPoint.zero, in: self)
        
        //percent
        
        //percent = 1 - Float((sender.location(in: parentView!).y) / (originalFrame.height-(self.parentViewController?.tabBarController?.tabBar.frame.height)!))
        
        let touchPosY = self.frame.origin.y-UIApplication.shared.statusBarFrame.height
        
        percent = 1 - Float(touchPosY / (parentView.frame.height - offset_top_y - offset_bottom_y))
        
        //print("height1 : \(sender.location(in: parentView).y-offset_top_y) and height2 : \(originalFrame.height+offset_top_y)")
        if sender.state == .began {
            //누르기 시작할 떄부터
            moved = sender.location(in: parentView!).y
        }
        
        if sender.state == .ended {
            //누르고 나서 얼마나 움직였는지 계산
            moved = moved - sender.location(in: parentView!).y
            
            //bottomBar_scroll_height 보다 많이 움직였을경우
            if moved.magnitude > bottomBar_scroll_height {
                self.make(parentView: parentView, dir: currentDir.getOpposite())
            }
            else {
                self.make(parentView: parentView, dir: currentDir)
            }
        }
        
    }
    
}

extension BackdropView {
    func make(parentView:UIView!,dir:direction) {
        
        if self.currentDir == dir {
            return
        }
        
        print("go to \(dir.hashValue)from\(currentDir.hashValue)")
        
        
        self.currentDir = dir
        
        var maketo:Float {
            if self.currentDir == direction.up {
                return opacity_max
            } else {
                return opacity_min
            }
        }
        self.percent = maketo
        
        UIView.animate(withDuration: 0.3, animations: {
            self.frame = self.getSize(parentView: parentView, dir: dir)
            self.percent = maketo
        })
        
        
    }
    
    func getSize(parentView:UIView!,dir:direction) -> CGRect {
        if dir == direction.up {
            return CGRect(x: 0, y: offset_top_y, width: parentView.frame.width, height: parentView.frame.height)
        } else {
            //origin은 왼쪽 위기 때문에 offset을 두번 연산해줘야 원하는 값이 나옴
            return CGRect(x: 0, y: parentView.frame.height - offset_bottom_y, width: parentView.frame.width, height: parentView.frame.height)
        }
    }
}
