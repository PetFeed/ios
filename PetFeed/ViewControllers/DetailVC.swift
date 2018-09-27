//
//  DetailVC.swift
//  PetFeed
//
//  Created by 이창현 on 2018. 9. 12..
//  Copyright © 2018년 이창현. All rights reserved.
//

import UIKit
import ImageSlideshow
class DetailVC: UIViewController,UIGestureRecognizerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var board:Board? {
        didSet {
            
        }
    }
    @IBOutlet weak var commentParentView: UIView!
    
    @IBOutlet weak var profileImageView: profileImageView!
    
    @IBOutlet weak var commentField: UITextField!
    @IBOutlet weak var commentFieldBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var sendButton: UIButton!
    
    var temp_images:[InputSource] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        
        profileImageView.sd_setImage(with: URL(string: API.base_url+API.currentUser.profile), placeholderImage: #imageLiteral(resourceName: "profile.jpeg"))
        
        tableView.register(UINib(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.interactivePopGestureRecognizer?.delegate = self

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
        commentField.delegate = self
        commentField.layer.masksToBounds = true
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: commentParentView.frame.height, right: 0)

    }
    @objc func keyboardWillShow(_ sender: Notification) {
        let userInfo:NSDictionary = sender.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        commentFieldBottomConstraint.constant  = keyboardHeight
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight+commentParentView.frame.height, right: 0)
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        commentFieldBottomConstraint.constant = 0
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: commentParentView.frame.height, right: 0)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func refreshBoard() {
        if let id = board?.id {
            API.Board.get(withID: id, token: API.currentToken) { (json) in
                if json["success"].boolValue == true {
                    let boardData = Board.transformUser(withJSON: json["data"])
                    self.board = boardData
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        if let board = self.board {
            API.Board.comment(withToken: API.currentToken, parent: board.id, content: commentField.text ?? "", type: "") { (json) in
                if json["success"].boolValue == true {
                    self.refreshBoard()
                }
            }
        }
        self.commentField.text = ""
        self.view.endEditing(true)
    }
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        
        if let id = board?.id,let likes = board?.likes {
            
            
            
            API.Board.like(withToken: API.currentToken, toBoardID: id, completion: { (json) in
                if json["success"].boolValue == true {
                    self.refreshBoard()
                } else {
                    self.show_alert(with: "Error")
                }
            })
        }
        
    }
    
    @IBAction func textFieldValueChanged(_ sender: UITextField) {
        if sender.text?.count == 0 {
            sendButton.isEnabled = false
        } else {
            sendButton.isEnabled = true
        }
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
                cell.superViewController = self
                if temp_images.count > 0 {
                    cell.imageShow.setImageInputs(temp_images)
                }
                
                
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
