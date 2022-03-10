//
//  constants.swift
//  MyChatApp
//
//  Created by nayan.khadase on 09/11/21.
//  Copyright © 2021 nayan.khadase. All rights reserved.
//

struct K {
    static let registerToChat = "RegisterToChat"
    static let loginToChat = "LoginToChat"
    static let messageCellIndentifier = "msgCell"
    static let nibName = "MessageTableViewCell"
    
    struct FireBase{
        static let collectionName = "messages"
        static let messageField = "message"
        static let emailField = "email"
        static let dateField = "date"
    }
}
