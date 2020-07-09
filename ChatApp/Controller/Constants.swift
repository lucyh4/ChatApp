//
//  Constants.swift
//  ChatApp
//
//  Created by Deepankar D on 07/04/20.
//  Copyright © 2020 Neha. All rights reserved.
//

struct K {
    static let appName = "⚡️FlashChat"
    static let registerSegue = "registerToHome"
    static let loginSegue = "loginToUsers"
    static let usersListSegue = "usersToChat"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
        static let usersCollectionName = "users"
        static let toId = "toId"
        static let uId = "uId"
        
        
    }
    
    struct Color {
        static let appDarkBlue = "DarkBlue"
        
        static let appLightPurple = "LightPurple"
        static let appDarkPurple = "DarkPurple"
        static let appOffWhite = "OffWhite"
    }
}

