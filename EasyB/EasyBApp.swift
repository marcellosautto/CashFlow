//
//  EasyBApp.swift
//  EasyB
//
//  Created by Marcello Sautto on 6/4/22.
//

import SwiftUI

@main
struct EasyBApp: App {
    
    @State var budgetData: BudgetInformation = BudgetInformation.sampleData[0]
    
    var bgUIColor = UIColor(red: 0.9, green: 0.95, blue: 0.95, alpha: 1.0)
    
    init(){
        UITableView.appearance().backgroundColor = bgUIColor
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView(budgetData: $budgetData)
        }
        
    }
}
