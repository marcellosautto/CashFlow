//
//  Expense.swift
//  EasyB
//
//  Created by Marcello Sautto on 6/4/22.
//

import Foundation

struct Expense: Identifiable {
    let id: UUID
    let name: String
    let cost: Float
    
    init(id: UUID = UUID(), name: String, cost: Float){
        self.id = id
        self.name = name
        self.cost = cost
    }
}
