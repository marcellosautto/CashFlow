//
//  BudgetInformationEditView.swift
//  CashFlow
//
//  Created by Marcello Sautto on 6/17/22.
//

import SwiftUI

struct BudgetInformationEditView: View {
    
    @EnvironmentObject var appViewModel: AppViewModel
    
    var body: some View {
        List {
            Section("Budget"){
                    VStack{
                        Text("Annual Income: $\(appViewModel.budgetInformation.yearlyIncome, specifier: "%.2f")")
                        Text("Monthly Income: $\(appViewModel.budgetInformation.monthlyIncome, specifier: "%.2f")")
                        Text("Remaining Income: $\(appViewModel.budgetInformation.remainingIncome, specifier: "%.2f")")
                        Text("Remaining Income Fraction: \(appViewModel.budgetInformation.remainingIncomeFraction, specifier: "%.0f") / 1")

                        
                    }
                    
                    VStack{
                        ForEach(appViewModel.expenseContainers){ container in
                            Text("Title: \(container.title)")
                            Text("Description: \(container.description)")
                            Text("Total: $\(container.total, specifier: "%.2f")")
                            Text("Relative Total: \(container.relativeTotal, specifier: "%.2f")%")
                            Text("Theme: \(container.theme.rawValue)")
                            
                            
                            ForEach(container.expenses){ expense in
                                Text("\(expense.name): $\(expense.cost, specifier: "%.2f")")
                                    .font(.subheadline)
                            }
                            
                            
                            
                        }
                    }

            }
            
        }
    }
}

struct BudgetInformationEditView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetInformationEditView()
            .environmentObject(AppViewModel())
    }
}
