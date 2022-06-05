//
//  ContentView.swift
//  EasyB
//
//  Created by Marcello Sautto on 6/4/22.
//

import SwiftUI

struct HomeView: View {
    
    @Binding var budgetData: BudgetInformation
    
    let bgColor: Color = Color(red: 0.9, green: 0.95, blue: 0.9)
    
    let textColor: Color = Color(red: 0.15, green: 0.15, blue: 0.15)
    
    var body: some View {
        VStack {
            Label("EasyB", systemImage: "dollarsign.circle")
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
            
            Divider()
            
            VStack(spacing: 20){
                Label("Expenses", systemImage: "creditcard")
                    .foregroundStyle(textColor)
                    .font(.title2.bold())
                
                
                VStack(spacing: 5) {
                    ForEach(budgetData.expenses){expense in
                        HStack{
                            Text("\(expense.name): $\(expense.cost, specifier: "%.2f")")
                                .font(.subheadline)
                        }
                    }
                }
                
            }
            
        }
        .background(bgColor)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(budgetData: .constant(BudgetInformation.sampleData[0]))
            .previewInterfaceOrientation(.portrait)
    }
}
