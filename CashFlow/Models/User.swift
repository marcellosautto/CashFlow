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
    
    init(id: String, email: String, password: String, budgetInformation: BudgetInformation, expenseContainers: [ExpenseContainer]){
        self.id = id
        self.email = email
        self.password = password
        self.budgetInformation = budgetInformation
        self.expenseContainers = expenseContainers
        
        updateAllIncome()
    }
    
}

extension User{
    
    struct Guest{
        var email: String = "guest"
        var password: String = ""
    }
    
    struct Data {
        let id: String = UUID().uuidString
        var email: String = ""
        var password: String = ""
        var budgetInformation: BudgetInformation = BudgetInformation(data: BudgetInformation.Data())
        var expenseContainers: [ExpenseContainer] = [ExpenseContainer]()
    }
    
    var data: Data {
        Data(email: email, password: password, budgetInformation: budgetInformation, expenseContainers: expenseContainers)
    }
    
    init(data: Data){
        id = data.id
        email = data.email
        password = data.password
        budgetInformation = data.budgetInformation
        expenseContainers = data.expenseContainers
        
        updateAllIncome()
    }
    
    mutating func update(from data: User.Data){
        email = data.email
        password = data.password
        budgetInformation = data.budgetInformation
        expenseContainers = data.expenseContainers
        
        updateAllIncome()
    }
    
    
    ///updates remaining income from all expense categories and sets their relative total
    mutating func updateAllIncome() -> Void{
        self.budgetInformation.remainingIncome = self.budgetInformation.monthlyIncome
        
        for i in 0..<self.expenseContainers.count{
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
    static let sampleUser = User(id: "zCKbunsJArhGvXyqgXa44uHfysJ2", email: "user@email.com", password: "password", budgetInformation: BudgetInformation.sampleData, expenseContainers: ExpenseContainer.sampleData)
}
