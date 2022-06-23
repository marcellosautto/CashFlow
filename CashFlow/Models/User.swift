//
//  User.swift
//  CashFlow
//
//  Created by Marcello Sautto on 6/15/22.
//

import Foundation
import Firebase

struct User{
    
    let id: String
    var email: String
    var password: String
    
}

extension User{
    
    struct Guest{
        var email: String = "guest"
        var password: String = ""
    }
}

extension User{
    static let sampleUser = User(id: "K3VaHcDLLkVnIX64HeBX", email: "user@email.com", password: "password")
}
