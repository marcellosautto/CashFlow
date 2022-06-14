//
//  ExpenseContainerView.swift
//  CashFlow
//
//  Created by Marcello Sautto on 6/13/22.
//

import SwiftUI

struct ExpenseContainerView: View {
    
    @Binding var budgetData: BudgetInformation
    @Binding var expenseContainerData: ExpenseContainer
    
    
    //NOT YET IMPLEMENTED
    var bgUIColor = UIColor(red: 0.9, green: 0.95, blue: 0.95, alpha: 1.0)
    
    var body: some View {
        ExpensesView(budgetData: $budgetData, expenseContainer: $expenseContainerData)
    }
}

struct ExpenseContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseContainerView(budgetData: .constant(BudgetInformation.sampleData),
                             expenseContainerData: .constant(ExpenseContainer.sampleData[0]))
    }
}
