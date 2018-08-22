//
//  LoginVC.swift
//  PetFeed
//
//  Created by 이창현 on 2018. 8. 21..
//  Copyright © 2018년 이창현. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var findButton: UIButton!
    
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        loginButton.backgroundColor = UIColor.camoGreen
        loginButton.layer.cornerRadius = 4
        loginButton.clipsToBounds = true
        
        
        idField.layer.borderColor = UIColor.camoGreen.cgColor
        idField.layer.borderWidth = 0.5
        idField.layer.cornerRadius = 4
        idField.clipsToBounds = true
        
        passwordField.layer.borderColor = UIColor.camoGreen.cgColor
        passwordField.layer.borderWidth = 0.5
        passwordField.layer.cornerRadius = 4
        passwordField.clipsToBounds = true
        
        let psString = NSMutableAttributedString(string: "아이디, 비밀번호 찾기", attributes: [
            .font: UIFont(name: "NanumSquareRoundOTFEB", size: 12.0)!,
            .foregroundColor: UIColor(white: 32.0 / 255.0, alpha: 1.0)
            ])
        psString.addAttribute(.font, value: UIFont(name: "NanumSquareRoundOTFR", size: 12.0)!, range: NSRange(location: 10, length: 2))
        
        registerButton.titleLabel?.attributedText = psString
        
        let idString = NSMutableAttributedString(string: "아이디, 비밀번호 찾기", attributes: [
            .font: UIFont(name: "NanumSquareRoundOTFEB", size: 12.0)!,
            .foregroundColor: UIColor(white: 32.0 / 255.0, alpha: 1.0)
            ])
        idString.addAttribute(.font, value: UIFont(name: "NanumSquareRoundOTFR", size: 12.0)!, range: NSRange(location: 10, length: 2))
        
        findButton.titleLabel?.attributedText = idString
        
        
        
        
    }

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "logined", sender: self)
    }
}
