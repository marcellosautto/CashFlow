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
    
    init(yearlyIncome: Float, isGrossIncome: Bool) {
        self.yearlyIncome = yearlyIncome
        self.monthlyIncome = yearlyIncome / 12.0
        self.remainingIncome = monthlyIncome
        self.isGrossIncome = isGrossIncome
        self.remainingIncomeFraction = 1.0
        
        
        //updateAllIncome()
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
        
    }
    

    var data: Data {
        Data(yearlyIncome: yearlyIncome, monthlyIncome: monthlyIncome, remainingIncome: remainingIncome, remainingIncomeFraction: remainingIncomeFraction, isGrossIncome: isGrossIncome)
    }
    
    ///data initializer
    init(data: Data){
        yearlyIncome = data.yearlyIncome
        monthlyIncome =  yearlyIncome / 12.0
        remainingIncome = data.remainingIncome
        remainingIncomeFraction = data.remainingIncomeFraction
        isGrossIncome = data.isGrossIncome
    }
    
    ///updates all BudgetInformation
    mutating func updateBudgetInfo(from data: Data){
        yearlyIncome = data.yearlyIncome
        monthlyIncome = yearlyIncome / 12.0
        remainingIncome = data.remainingIncome
        remainingIncomeFraction = data.remainingIncomeFraction
        isGrossIncome = data.isGrossIncome
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
    
    static let sampleData: BudgetInformation = BudgetInformation(yearlyIncome: 100000, isGrossIncome: true)
    
}
