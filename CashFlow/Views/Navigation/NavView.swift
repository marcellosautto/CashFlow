//
//  NavView.swift
//  CashFlow
//
//  Created by Marcello Sautto on 6/27/22.
//

import SwiftUI

struct NavView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject var appViewModel = AppViewModel()
    
    var body: some View {
        TabView{
            HomeView()
                .environmentObject(authViewModel)
                .environmentObject(appViewModel)
                .tabItem{
                    Text("Home")
                    Image(systemName: "house")
                }
            
            ExpenseLogView()
                .environmentObject(appViewModel)
                .tabItem{
                    Text("Expense Log")
                    Image(systemName: "dollarsign.circle")
                }
            
            InsightsView()
                .environmentObject(appViewModel)
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
}

struct NavView_Previews: PreviewProvider {
    static var previews: some View {
        NavView()
    }
}
