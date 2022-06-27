//
//  SettingsView.swift
//  CashFlow
//
//  Created by Marcello Sautto on 6/26/22.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        
        VStack(spacing: 50){
            Text("Settings")
                .font(.title)
            
            Button("Sign Out"){
                authViewModel.signOut()
            }
            
            Spacer()
        }
        
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(AuthViewModel())
    }
}
