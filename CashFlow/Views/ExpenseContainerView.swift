//
//  ExpenseContainerView.swift
//  CashFlow
//
//  Created by Marcello Sautto on 6/13/22.
//

import SwiftUI

struct ExpenseContainerView: View {
    
    @State var isPresentingEditView: Bool = false
    @State var newExpenseContainerData = ExpenseContainer.Data()
    @Binding var budgetData: BudgetInformation
    @Binding var expenseContainerData: ExpenseContainer
    
    
    //NOT YET IMPLEMENTED
    var bgUIColor = UIColor(red: 0.9, green: 0.95, blue: 0.95, alpha: 1.0)
    
    var body: some View {
        VStack{
            ExpensesView(budgetData: $budgetData, expenseContainer: $expenseContainerData)
        }
        .sheet(isPresented: $isPresentingEditView){
            NavigationView{
                ExpenseContainerEditView(newExpenseContainerData: $newExpenseContainerData)
                    .navigationTitle(expenseContainerData.title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction){
                            Button("Cancel"){
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done"){
                                isPresentingEditView = false
                                
                                expenseContainerData.updateExpenseContainer(from: newExpenseContainerData)
                                
                                
                            }
                        }
                        
                    }
            }
        }
        .toolbar{
            ToolbarItem(placement: .confirmationAction){
                Button("Edit"){
                    isPresentingEditView = true
                    newExpenseContainerData = expenseContainerData.data
                }
            }
        }
        
        
    }
}

struct ExpenseContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseContainerView(budgetData: .constant(BudgetInformation.sampleData),
                             expenseContainerData: .constant(ExpenseContainer.sampleData[0]))
    }
}
