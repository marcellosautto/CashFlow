//
//  EasyBApp.swift
//  EasyB
//
//  Created by Marcello Sautto on 6/4/22.
//

import SwiftUI
import Firebase

@main
struct CashFlowApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject private var authViewModel: AuthViewModel = AuthViewModel()
    //@State var user: User = User.sampleUser
    
    var bgUIColor = UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1) 
    
    init(){
        UITableView.appearance().backgroundColor = bgUIColor
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                RouterView()
                    .environmentObject(authViewModel)
            }
            .onAppear{
                authViewModel.signedIn = authViewModel.isSignedIn
            }
            
        }
        
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        return true
    }
}
