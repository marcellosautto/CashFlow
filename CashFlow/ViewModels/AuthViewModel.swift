//
//  AuthViewModel.swift
//  CashFlow
//
//  Created by Marcello Sautto on 6/23/22.
//

import SwiftUI
import Firebase
import FirebaseDatabase

class AuthViewModel: ObservableObject {
    
    //MARK: AUTHENTICATION
    @Published var user: User = User(data: User.Data())
    @Published var signedIn = false
    
    let auth = Auth.auth()
    let dbref = Database.database().reference()
    
    
    var isSignedIn: Bool{
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String){
        auth.signIn(withEmail: email, password: password) {
            [weak self] result, error in
            guard result != nil, error == nil else{
                return
            }
            
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    
    func signUp(email: String, password: String){
        auth.createUser(withEmail: email, password: password) {
            [weak self] result, error in
            guard result != nil, error == nil else{
                return
            }
            
            DispatchQueue.main.async {
                self?.signedIn = true
                self?.dbref.child("users").child(self?.auth.currentUser!.uid as! String).setValue( //this probably needs to be addressed at some point
                    ["email": email, "password": password]
                )
            }
        }
        

    }
    
    func signOut() {
        try? auth.signOut()
        
        self.signedIn = false
    }
    
}

