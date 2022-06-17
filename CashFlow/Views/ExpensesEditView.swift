//
//  ExpensesEditView.swift
//  EasyB
//
//  Created by Marcello Sautto on 6/5/22.
//

import SwiftUI

struct ExpensesEditView: View {
    
    @Binding var expenseData: Expense.Data
    
    var body: some View {
        Form {
            Section(header: Text("Expense Info")){
                TextField("Name", text: $expenseData.name)
                TextField("Cost", value: $expenseData.cost, format: .currency(code: "USD"))
            }
            
        }
    }
}

struct ExpensesEditView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesEditView(expenseData: .constant(Expense.Data()) )
    }
}
