//
//  RouterView.swift
//  CashFlow
//
//  Created by Marcello Sautto on 6/15/22.
//

import SwiftUI
import Firebase

struct RouterView: View {
    
    @StateObject private var appViewModel: AppViewModel = AppViewModel()
    @EnvironmentObject var authViewModel: AuthViewModel
    
    //@Binding var user: User
    
    var body: some View {
        
        if authViewModel.isSignedIn {
            
            HomeView()
                .environmentObject(authViewModel)
                .environmentObject(appViewModel)
        }
        else{
            SignInView()
                .environmentObject(authViewModel)
        }
    }
    
}

struct RouterView_Previews: PreviewProvider {
    static var previews: some View {
        RouterView()
            .environmentObject(AuthViewModel())
    }
}
