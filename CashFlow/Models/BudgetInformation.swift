//
//  BudgetInformation.swift
//  EasyB
//
//  Created by Marcello Sautto on 6/4/22.
//

import Foundation

//Stores all user budget information

struct BudgetInformation{
    
    var yearlyIncome: Float
    var monthlyIncome: Float
    var remainingIncome: Float
    var remainingIncomeFraction: Float
    var isGrossIncome: Bool
    var expenseContainers: [ExpenseContainer]
    
    init(yearlyIncome: Float, isGrossIncome: Bool, expenseContainers: [ExpenseContainer]) {
        self.yearlyIncome = yearlyIncome
        self.monthlyIncome = yearlyIncome / 12.0
        self.remainingIncome = monthlyIncome
        self.isGrossIncome = isGrossIncome
        self.expenseContainers = expenseContainers
        self.remainingIncomeFraction = 1.0
        
        
        updateAllIncome()
    }
    
 
}

extension BudgetInformation {
    
    ///Data is used for handeling CRUD operations
    struct Data {
        var yearlyIncome: Float = 0
        var monthlyIncome: Float = 0
        var remainingIncome: Float = 0
        var remainingIncomeFraction: Float = 0
        var isGrossIncome: Bool = true
        var expenseContainers: [ExpenseContainer] = []
        
    }
    

    var data: Data {
        Data(yearlyIncome: yearlyIncome, monthlyIncome: monthlyIncome, remainingIncome: remainingIncome, remainingIncomeFraction: remainingIncomeFraction, isGrossIncome: isGrossIncome, expenseContainers: expenseContainers)
    }
    
    ///data initializer
    init(data: Data){
        yearlyIncome = data.yearlyIncome
        monthlyIncome = data.monthlyIncome
        remainingIncome = data.remainingIncome
        remainingIncomeFraction = data.remainingIncomeFraction
        isGrossIncome = data.isGrossIncome
        expenseContainers = data.expenseContainers
    }
    
    ///updates all BudgetInformation
    mutating func updateBudgetInfo(from data: Data){
        yearlyIncome = data.yearlyIncome
        monthlyIncome = data.monthlyIncome
        remainingIncome = data.remainingIncome
        remainingIncomeFraction = data.remainingIncomeFraction
        isGrossIncome = data.isGrossIncome
        expenseContainers = data.expenseContainers
        updateAllIncome()
        
    }

    ///updates remaining income from all expense categories and sets their relative total
    mutating func updateAllIncome() -> Void{
        self.remainingIncome = self.monthlyIncome
        
        for i in 0...self.expenseContainers.count-1{
            if (!expenseContainers[i].expenses.isEmpty){
                
                for expense in expenseContainers[i].expenses{
                    self.remainingIncome -= expense.cost
                }
                
                self.remainingIncomeFraction = remainingIncome / monthlyIncome
            }
            
            expenseContainers[i].setRelativeTotal(monthlyIncome: monthlyIncome)
            
        }
        

    }
    
//    mutating func updateRemainingIncome(from container: ExpenseContainer) -> Void{
//        if (!container.expenses.isEmpty){
//            self.remainingIncome = self.monthlyIncome
//
//            for expense in container.expenses{
//                self.remainingIncome -= expense.cost
//            }
//
//            remainingIncomeFraction = remainingIncome / monthlyIncome
//        }
//    }
    

}

extension BudgetInformation{
    
    static let sampleData: BudgetInformation = BudgetInformation(yearlyIncome: 100000, isGrossIncome: true, expenseContainers: ExpenseContainer.sampleData)
    
}
