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
    
    var id:String = ""
    var password:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
            
            if password != re_passwordfield.text {
                show_alert(with: "비밀번호가 맞지 않습니다.")
                return
            }
            
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "register2") as! RegisterVC
            self.present(vc, animated: true) {
                vc.registerReady(withID: id, andPS: password)
            }
        } else if sender.tag == 1 { //End
            API.Auth.register(id: id, password: password) { (json) in
                if json["success"].boolValue == false {
                    self.show_alert(with: json["message"].stringValue)
                } else {
                    self.show_alert(with: json.description)
                    //self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                }
            }
            
        }
    }
    
    func registerReady(withID id:String,andPS password:String) {
        self.id = id
        self.password = password
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
