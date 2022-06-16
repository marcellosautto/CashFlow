//
//  User.swift
//  CashFlow
//
//  Created by Marcello Sautto on 6/15/22.
//

import Foundation
import Firebase

struct User: Identifiable{
    
    let userID: Int
    var email: String
    var password: String
    
    var id: Int {
        return userID
    }
}

extension User{
    
    struct Guest{
        var email: String = "guest"
        var password: String = ""
    }
}

extension User{
    static let sampleUser = User(userID: 0, email: "user@email.com", password: "password")
}
