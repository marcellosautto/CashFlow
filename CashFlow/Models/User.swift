//
//  User.swift
//  CashFlow
//
//  Created by Marcello Sautto on 6/15/22.
//

import Foundation
import Firebase

struct User{
    
    let id: String
    var email: String
    var password: String
    var budgetInformation: BudgetInformation
    var expenseContainers: [ExpenseContainer]
    
}

extension User{
    
    struct Guest{
        var email: String = "guest"
        var password: String = ""
    }
    
    ///updates remaining income from all expense categories and sets their relative total
    mutating func updateAllIncome() -> Void{
        self.budgetInformation.remainingIncome = self.budgetInformation.monthlyIncome
        
        for i in 0...self.expenseContainers.count-1{
            if (!expenseContainers[i].expenses.isEmpty){
                
                for expense in expenseContainers[i].expenses{
                    self.budgetInformation.remainingIncome -= expense.cost
                }
                
                self.budgetInformation.remainingIncomeFraction = self.budgetInformation.remainingIncome / self.budgetInformation.monthlyIncome
            }
            
            self.expenseContainers[i].setRelativeTotal(monthlyIncome: self.budgetInformation.monthlyIncome)
            
        }
        

    }
}

extension User{
    static let sampleUser = User(id: "K3VaHcDLLkVnIX64HeBX", email: "user@email.com", password: "password", budgetInformation: BudgetInformation.sampleData, expenseContainers: ExpenseContainer.sampleData)
}
