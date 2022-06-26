//
//  BudgetInformationEditView.swift
//  CashFlow
//
//  Created by Marcello Sautto on 6/17/22.
//

import SwiftUI

struct BudgetInformationEditView: View {
    
    @Binding var budgetData: BudgetInformation
    
    var body: some View {
        Form{
            Section("Budget"){
                VStack{
                    
                    Picker("Type", selection: $budgetData.isGrossIncome) {
                        Text("Gross Income").tag(true)
                        Text("Net Income").tag(false)
                        
                    }
                    
                    TextField("Annual Income: $", value: $budgetData.yearlyIncome, format: .currency(code: "USD"))
                    
                }
                
            }
        }
        
    }
}

struct BudgetInformationEditView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetInformationEditView(budgetData: .constant(BudgetInformation.sampleData))
    }
}
