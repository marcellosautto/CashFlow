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
    
    //@Binding var user: User
    
    var body: some View {
        
        if authViewModel.isSignedIn {
            
            TabView{
                HomeView()
                    .environmentObject(authViewModel)
                    .tabItem{
                        Text("Home")
                        Image(systemName: "house")
                    }
                
                InsightsView()
                    .tabItem{
                        Text("Insights")
                        Image(systemName: "chart.line.uptrend.xyaxis")
                    }
                
                SettingsView()
                    .environmentObject(authViewModel)
                    .tabItem{
                        Text("Settings")
                        Image(systemName: "gear")
                    }
                

            }
            
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
