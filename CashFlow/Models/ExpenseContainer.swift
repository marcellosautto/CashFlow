//
//  ExpenseContainer.swift
//  CashFlow
//
//  Created by Marcello Sautto on 6/13/22.
//

import Foundation

///customizable containers the user creates to store and itemize their expenses
struct ExpenseContainer: Identifiable {
    
    let id: UUID
    var title: String
    var description: String
    var expenses: [Expense]
    var total: Float
    var relativeTotal: Float
    var theme: Theme
    
    init(id: UUID = UUID(), title: String, description: String, expenses: [Expense], theme: Theme){
        self.id = id
        self.title = title
        self.description = description
        self.expenses = expenses
        self.theme = theme
        self.total = 0
        self.relativeTotal = 0
        
        setTotalExpenses()
        
    }
    
    
}

///Extension for handling CRUD operations
extension ExpenseContainer{
    
    struct Data {
        let id: UUID = UUID()
        var title: String = ""
        var description: String = ""
        var expenses: [Expense] = []
        var total: Float = 0
        var relativeTotal: Float = 0
        var theme: Theme = .indigo
    }
    
    var data: Data {
        Data(title: title, description: description, expenses: expenses, total: total, relativeTotal: relativeTotal, theme: theme)
    }
    
    init(data: Data){
        id = data.id
        title = data.title
        description = data.description
        expenses = data.expenses
        theme = data.theme
        total = data.total
        relativeTotal = data.relativeTotal
        
    }
    
    mutating func updateExpenseContainer(from data: ExpenseContainer.Data) {
        title = data.title
        description = data.description
        theme = data.theme
        
    }
    
    mutating func updateExpenseInfo(from data: Expense.Data){
        if let idx = self.expenses.firstIndex(where: {$0.id == data.id}) {
            expenses[idx].name = data.name
            expenses[idx].cost = data.cost
            
        }
        
        setTotalExpenses()
    }
    
    
    mutating func setTotalExpenses()-> Void{
        self.total = 0
        
        for expense in expenses{
            self.total += expense.cost
        }
        
    }
    
    mutating func setRelativeTotal(monthlyIncome: Float)-> Void{
        self.relativeTotal = (total / monthlyIncome) * 100
        
    }
    
}


extension ExpenseContainer{
    static let sampleData: [ExpenseContainer] = [
        ExpenseContainer(title: "Fixed Expenses", description: "Morgage and Insurance", expenses: Expense.sampleData[0], theme: .bubblegum),
        ExpenseContainer(title: "Savings", description: "401k and Emergency", expenses: Expense.sampleData[1], theme: .indigo)
    ]
}
