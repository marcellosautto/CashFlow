//
//  RealExpense.swift
//  CashFlow
//
//  Created by Marcello Sautto on 6/27/22.
//

import Foundation

struct RealExpense: Identifiable{
    
    let id: UUID
    var name: String
    var cost: Float
    var date: Date
    var containerDescriptor: ContainerDescriptor
    
    init(id: UUID = UUID(), name: String, cost: Float, date: Date = Date(), containerDescriptor: ContainerDescriptor){
        self.id = id
        self.name = name
        self.cost = cost
        self.date = date
        self.containerDescriptor = containerDescriptor
    }
}

extension RealExpense{
    
    struct ContainerDescriptor: Identifiable{
        var title: String
        var theme: Theme
        var id = ObjectIdentifier(ContainerDescriptor.self)
    }
    
    struct Data{
        let id: UUID = UUID()
        var name: String = ""
        var cost: Float = 0
        var date: Date = Date()
        var containerDescriptor: ContainerDescriptor = ContainerDescriptor(title: "", theme: .bubblegum)
    }
    
    init(data: Data){
        id = data.id
        name = data.name
        cost = data.cost
        date = data.date
        containerDescriptor = data.containerDescriptor
    }
    
    var data: Data {
        Data(name: name, cost: cost, date: date, containerDescriptor: containerDescriptor)
    }
    

}

extension RealExpense{
    static let sampleData: [RealExpense] = [
        RealExpense(name: "Name", cost: 0, containerDescriptor: ContainerDescriptor(title: "container", theme: .purple)),
        RealExpense(name: "Name2", cost: 0, containerDescriptor: ContainerDescriptor(title: "container2", theme: .bubblegum))
    ]
}
