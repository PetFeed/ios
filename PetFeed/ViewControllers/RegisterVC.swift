//
//  RegisterVC.swift
//  PetFeed
//
//  Created by 이창현 on 2018. 8. 21..
//  Copyright © 2018년 이창현. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {
    
    @IBOutlet weak var idField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var re_passwordfield: UITextField!
    
    @IBOutlet weak var nickNameField: UITextField!
    
    
    
    var id:String = ""
    var password:String = ""
    var nickname:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        let userInfo:NSDictionary = sender.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        self.view.frame.origin = CGPoint(x: 0, y: -100)
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin = CGPoint(x: 0, y: 0)
    }

    @IBAction func exitButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if sender.tag == 0 { //첫화면
            guard let id = idField.text,!id.isEmpty else {
                show_alert(with: "아이디를 입력해주세요.")
                return
            }
            guard let password = passwordField.text,!password.isEmpty else {
                show_alert(with: "비밀번호를 입력해주세요.")
                return
            }
            guard let nickname = nickNameField.text,!nickname.isEmpty else {
                show_alert(with: "닉네임을 입력해주세요.")
                return
            }
            
            if password != re_passwordfield.text {
                show_alert(with: "비밀번호가 맞지 않습니다.")
                return
            }
            
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "register2") as! RegisterVC
            self.present(vc, animated: true) {
                vc.registerReady(withID: id, andPS: password, name: nickname)
            }
        } else if sender.tag == 1 { //End
            
            API.Auth.register(id: id, password: password,nickname: nickname) { (json) in
                if json["success"].boolValue == false {
                    self.show_alert(with: json["message"].stringValue)
                } else {
                    //self.show_alert(with: json.description)
                    self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                }
            }
            
        }
    }
    
    func registerReady(withID id:String,andPS password:String,name nickname:String) {
        self.id = id
        self.password = password
        self.nickname = nickname
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
