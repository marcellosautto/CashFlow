//
//  SettingsView.swift
//  CashFlow
//
//  Created by Marcello Sautto on 6/26/22.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    let bgColor: Color = Color(red: 0.94, green: 0.94, blue: 0.94)
    
    var body: some View {
        
        ZStack{
            bgColor.ignoresSafeArea(edges: .all)

            VStack{
                Text("Settings")
                    .font(.title)
                    .padding(.bottom)
                HStack{
                    Label("\(authViewModel.user.email)", systemImage: "person.fill")
                }
                List {
                    NavigationLink {
                        ResetPasswordView()
                    } label: {
                        Text("Change Password")
                            .foregroundStyle(.cyan)
                    }
                    Button("Sign Out"){
                        authViewModel.signOut()
                    }
                }
                
                Spacer()
            }.padding()
            
        }
        
        
        
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(AuthViewModel())
    }
}
