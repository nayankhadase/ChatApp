//
//  ChatViewController.swift
//  MyChatApp
//
//  Created by nayan.khadase on 22/10/21.
//  Copyright © 2021 nayan.khadase. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var chatText: UITextField!
    
    
    var chats: [Message] = [Message]()
    
    let fireBaseHelper = FireBaseHelper()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: K.nibName, bundle: nil), forCellReuseIdentifier: K.messageCellIndentifier)
        chatText.backgroundColor = UIColor(named: "BrandLightPurple")
        loadMessagesData()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "MyChatApp"
        navigationItem.hidesBackButton = true
    }
    
    
    func loadMessagesData(){
        //method from fireBaseHelper
        fireBaseHelper.loadMessageData(for: K.FireBase.collectionName, orderBy: K.FireBase.dateField) { messages, err in
            guard let messages = messages else {
                print("error while loadind data from firebase: \(err!.localizedDescription)")
                return
            }
            self.chats = messages
            if !self.chats.isEmpty{
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    let indexPath = IndexPath(row: self.chats.count - 1, section: 0)
                    self.tableView.scrollToRow(at: indexPath, at: .none, animated: true)
                }
            }
        }
        
        //
//        let db = Firestore.firestore()
//        db.collection(K.FireBase.collectionName)
//            .order(by: K.FireBase.dateField)
//            .addSnapshotListener { (querySnapshot, err) in
//                self.chats = []
//                if let err = err {
//                    print("Error getting documents: \(err)")
//                } else {
//                    for document in querySnapshot!.documents {
//                        print("\(document.documentID) => \(document.data())")
//                        let data = document.data()
//                        self.chats.append(Message(sender: data[K.FireBase.emailField]! as! String, msg: data[K.FireBase.messageField]! as! String))
//                    }
//
//                    if !self.chats.isEmpty{
//                        DispatchQueue.main.async {
//                            self.tableView.reloadData()
//                            let indexPath = IndexPath(row: self.chats.count - 1, section: 0)
//                            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
//                        }
//                    }
//
//                }
//        }
    }
    
   
    
    
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        fireBaseHelper.logOutUser { isLogOut, err in
            guard isLogOut else{
                print("error while signOut: \(err!.localizedDescription)")
                return
            }
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @IBAction func sendBtnPressed(_ sender: UIButton) {
        guard let msg = chatText.text else {return}
        fireBaseHelper.sendData(to: K.FireBase.collectionName, with: msg) { isSent, err in
            if isSent{
                DispatchQueue.main.async {
                    self.chatText.text = ""
                }
            }else{
                print("error while sending the data: \(err!.localizedDescription)")
            }
        }
    }
}
extension ChatViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count: \(chats.count)")
        return chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !chats.isEmpty{
            let a = chats[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: K.messageCellIndentifier, for: indexPath) as! MessageTableViewCell
            
            if a.sender == Auth.auth().currentUser?.email{
                cell.youImage.isHidden = true
                cell.imgLabel.isHidden = false
                cell.msgLabel.textColor = UIColor(named: "BrandPurple")
                cell.msgBubble.backgroundColor = UIColor(named: "BrandLightPurple")
            }else{
                cell.youImage.isHidden = false
                cell.imgLabel.isHidden = true
                cell.msgLabel.textColor = UIColor(named: "BrandLightPurple")
                cell.msgBubble.backgroundColor = UIColor(named: "BrandPurple")
            }
            
            
            cell.msgLabel.text = chats[indexPath.row].msg
            
            return cell
        } else{
           return UITableViewCell()
        }
        
        
    }
    
    
}
