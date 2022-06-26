//
//  Expense.swift
//  EasyB
//
//  Created by Marcello Sautto on 6/4/22.
//

import Foundation

///Represents each expense a user adds to their expense containers
struct Expense: Identifiable {
    let id: UUID
    var name: String
    var cost: Float
    
    init(id: UUID = UUID(), name: String, cost: Float){
        self.id = id
        self.name = name
        self.cost = cost
    }
}

extension Expense {
    struct Data {
        var id: UUID = UUID()
        var name: String = ""
        var cost: Float = 0
        
    }
    
}

extension Expense{
    var data: Data {
        Data(id: id, name: name, cost: cost)
    }
    
    init(data: Data){
        id = UUID()
        name = data.name
        cost = data.cost
    }
}

extension Expense{
    static let sampleData: [[Expense]] = [
        [Expense(name: "Rent", cost: 2000),Expense(name: "Utilities", cost: 150.0)],
        [Expense(name: "401k", cost: 1000),Expense(name: "Vacation", cost: 200)]
        
    ]
}
