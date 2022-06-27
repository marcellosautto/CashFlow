//
//  ExpenseContainerEditView.swift
//  CashFlow
//
//  Created by Marcello Sautto on 6/14/22.
//

import SwiftUI

struct ExpenseContainerEditView: View {
    
    @Binding var newExpenseContainerData: ExpenseContainer.Data
    
    var body: some View {
        Form{
            Section("Title"){
                TextField("Enter title...", text: $newExpenseContainerData.title)
            }
            Section("Description"){
                TextField("Enter title...", text: $newExpenseContainerData.description)
            }
            Section("Theme"){
                ThemePicker(selection: $newExpenseContainerData.theme)
            }
        }
    }
}

struct ExpenseContainerEditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ExpenseContainerEditView(newExpenseContainerData: .constant(ExpenseContainer.sampleData[0].data))
        }
        
    }
}
