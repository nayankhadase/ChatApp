//
//  FireBaseHelper.swift
//  MyChatApp
//
//  Created by Nayan Khadase on 10/03/22.
//  Copyright © 2022 nayan.khadase. All rights reserved.
//

import Foundation
import Firebase


class FireBaseHelper{
    private let db = Firestore.firestore()
    
    func loadMessageData(for collectionName: String, orderBy field: String, completion: @escaping ([Message]?, Error?) -> Void){
        var msgArray = [Message]()
        db.collection(collectionName)
            .order(by:field)
            .addSnapshotListener { querySnapshot, err in
                if let err = err {
//                    print("Error getting documents: \(err)")
                    completion(nil, err)
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        let data = document.data()
                        let msg = data[K.FireBase.messageField] as! String
                        let sender = data[K.FireBase.emailField] as! String
                        msgArray.append(Message(sender: sender, msg: msg))
                    }
                    completion(msgArray, nil)
                }
            }
    }
    
    
    func logOutUser(completion: (Bool, Error?) -> Void){
        let firebaseAuth = Auth.auth()
        do{
            try firebaseAuth.signOut()
            completion(true, nil)
        }catch{
            completion(false, error)
        }
    }
    
    
    func sendData(to collectionName: String, with message: String, completion: @escaping (Bool,Error?) -> Void){
        guard let email = Auth.auth().currentUser?.email else{
            return
        }
        let msgData: [String: Any] = [
            K.FireBase.messageField: message,
            K.FireBase.emailField: email,
            K.FireBase.dateField: Date().timeIntervalSince1970
        ]
        db.collection(collectionName)
            .addDocument(data: msgData) { err in
                if let err = err{
                    completion(false, err)
                }else{
                    completion(true, nil)
                }
                
            }
    }
    
}
