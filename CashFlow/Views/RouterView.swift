//
//  RouterView.swift
//  CashFlow
//
//  Created by Marcello Sautto on 6/15/22.
//

import SwiftUI
import Firebase

struct RouterView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject private var appViewModel: AppViewModel = AppViewModel()
    
    @Binding var user: User
    
    var body: some View {
        
        if authViewModel.isSignedIn {
            
            HomeView(user: $user)
                .environmentObject(authViewModel)
                .environmentObject(appViewModel)
        }
        else{
            SignInView(user: $user)
                .environmentObject(authViewModel)
        }
    }
    
}

struct RouterView_Previews: PreviewProvider {
    static var previews: some View {
        RouterView(user: .constant(User.sampleUser))
            .environmentObject(AuthViewModel())
    }
}
