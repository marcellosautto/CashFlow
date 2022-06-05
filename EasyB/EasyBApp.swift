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
    var body: some Scene {
        WindowGroup {
            HomeView(budgetData: $budgetData)
        }
    }
}
