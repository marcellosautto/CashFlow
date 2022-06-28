//
//  ExpenseLogEditView.swift
//  CashFlow
//
//  Created by Marcello Sautto on 6/27/22.
//

import SwiftUI

struct ExpenseLogEditView: View {
    
    @Binding var realExpense: RealExpense.Data
    
    @State var containerIndex: Int = 0
    
    @EnvironmentObject var appViewModel: AppViewModel
    
    var body: some View {
        Form{
            Section("Name"){
                TextField("Name", text: $realExpense.name)
            }
            
            Section("Cost"){
                TextField("Cost", value: $realExpense.cost, format: .currency(code: "USD"))
            }
            
            Section("Category"){
                RealExpenseContainerPicker(containers: appViewModel.user.expenseContainers, containerIndex: $containerIndex)
                    .onDisappear(){
                        realExpense.containerDescriptor.title = appViewModel.user.expenseContainers[containerIndex].title
                        
                        realExpense.containerDescriptor.theme = appViewModel.user.expenseContainers[containerIndex].theme
                    }
      
            }
            
        }
        
    }
}

struct ExpenseLogEditView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseLogEditView(realExpense: .constant(RealExpense.sampleData[0].data))
            .environmentObject(AppViewModel())
    }
}
