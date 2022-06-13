//
//  BudgetInformation.swift
//  EasyB
//
//  Created by Marcello Sautto on 6/4/22.
//

import Foundation

struct BudgetInformation{
    
    var yearlyIncome: Float
    var monthlyIncome: Float
    var remainingIncome: Float
    var remainingIncomeFraction: Float
    var isGrossIncome: Bool
    var expenses: [Expense]
    
    init(yearlyIncome: Float, isGrossIncome: Bool, expenses: [Expense]) {
        self.yearlyIncome = yearlyIncome
        self.monthlyIncome = yearlyIncome / 12.0
        self.remainingIncome = monthlyIncome
        self.isGrossIncome = isGrossIncome
        self.expenses = expenses
        self.remainingIncomeFraction = 1.0
        
        
        updateRemainingIncome()
    }
    
 
}

extension BudgetInformation {
    
    struct Data {
        var yearlyIncome: Float = 0
        var monthlyIncome: Float = 0
        var remainingIncome: Float = 0
        var remainingIncomeFraction: Float = 0
        var isGrossIncome: Bool = true
        var expenses: [Expense] = []
        
    }
    
    var data: Data {
        Data(yearlyIncome: yearlyIncome, monthlyIncome: monthlyIncome, remainingIncome: remainingIncome, remainingIncomeFraction: remainingIncomeFraction, isGrossIncome: isGrossIncome, expenses: expenses)
    }
    
    init(data: Data){
        yearlyIncome = data.yearlyIncome
        monthlyIncome = data.monthlyIncome
        remainingIncome = data.remainingIncome
        remainingIncomeFraction = data.remainingIncomeFraction
        isGrossIncome = data.isGrossIncome
        expenses = data.expenses
    }
    
    mutating func updateBudgetInfo(from data: Data){
        yearlyIncome = data.yearlyIncome
        monthlyIncome = data.monthlyIncome
        remainingIncome = data.remainingIncome
        remainingIncomeFraction = data.remainingIncomeFraction
        isGrossIncome = data.isGrossIncome
        expenses = data.expenses
        
        updateRemainingIncome()
    }
    
    mutating func updateExpenseInfo(from data: Expense.Data){
        if let idx = self.expenses.firstIndex(where: {$0.id == data.id}) {
            expenses[idx].name = data.name
            expenses[idx].cost = data.cost
            
        }
        
        updateRemainingIncome()
    }

    
    mutating func updateRemainingIncome() -> Void{
        if (!self.expenses.isEmpty){
            self.remainingIncome = self.monthlyIncome
            
            for expense in self.expenses{
                self.remainingIncome -= expense.cost
            }
            
            remainingIncomeFraction = remainingIncome / monthlyIncome
        }
    }
}

extension BudgetInformation{
    
    static let sampleData: [BudgetInformation] = [
        BudgetInformation(yearlyIncome: 100000.0, isGrossIncome: true,
                          expenses: Expense.sampleData)
    ]
    
    
    
}
