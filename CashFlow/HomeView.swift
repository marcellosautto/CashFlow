//
//  ContentView.swift
//  EasyB
//
//  Created by Marcello Sautto on 6/4/22.
//

import SwiftUI

struct HomeView: View {
    
    @Binding var budgetData: BudgetInformation
    
    let textColor: Color = Color(red: 0.15, green: 0.15, blue: 0.15)
    let bgColor: Color = Color(red: 0.9, green: 0.95, blue: 0.95)
    
    
    var body: some View {
        
        ZStack {
            bgColor.ignoresSafeArea(edges: .all)
            
            VStack {
                Label("CashFlow", systemImage: "dollarsign.circle")
                    .foregroundStyle(textColor)
                    .font(.largeTitle.bold().italic())
                    .padding()
                
                ZStack{
                    VisualizedIncomeView(budgetData: $budgetData)
                    
                    Text("$\(budgetData.remainingIncome, specifier: "%.2f")")
                        .foregroundStyle(textColor)
                        .font(.largeTitle)
                        .accessibilityLabel("Money remaining")
                    
                }
                
                ExpensesView(budgetData: $budgetData)
                
            }
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(budgetData: .constant(BudgetInformation.sampleData[0]))
    }
    
}
