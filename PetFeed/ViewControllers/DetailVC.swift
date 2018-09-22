//
//  DetailVC.swift
//  PetFeed
//
//  Created by 이창현 on 2018. 9. 12..
//  Copyright © 2018년 이창현. All rights reserved.
//

import UIKit

class DetailVC: UIViewController,UIGestureRecognizerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var board:Board? {
        didSet {
            print(board.debugDescription)
            //tableView.reloadData()
        }
    }
    @IBOutlet weak var commentParentView: UIView!
    
    @IBOutlet weak var profileImageView: profileImageView!
    
    @IBOutlet weak var commentField: UITextField!
    @IBOutlet weak var commentFieldBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        
        tableView.register(UINib(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.interactivePopGestureRecognizer?.delegate = self

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
        commentField.delegate = self
        commentField.layer.masksToBounds = true

    }
    @objc func keyboardWillShow(_ sender: Notification) {
        let userInfo:NSDictionary = sender.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        commentFieldBottomConstraint.constant  = keyboardHeight
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        commentFieldBottomConstraint.constant = 0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        //self.navigationController?.isNavigationBarHidden = false
    }

    
}

extension DetailVC: UITextFieldDelegate {
    
}

extension DetailVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (board?.comments.count ?? 0) + 1
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
            let comment = board?.comments[indexPath.row-1]
            cell.initialize(profile: #imageLiteral(resourceName: "content.jpeg"), name: comment?.writer_nickname ?? "", content: comment?.content ?? "", date: comment?.date ?? Date())
            return cell
        }
    }
}
