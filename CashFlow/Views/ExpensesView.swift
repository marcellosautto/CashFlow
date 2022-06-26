//
//  ExpensesView.swift
//  EasyB
//
//  Created by Marcello Sautto on 6/5/22.
//

import SwiftUI

struct ExpensesView: View {
    
    @State private var newExpenseData = Expense.Data()
    @State private var isPresentingEditView = false
    @State private var isPresentingNewExpenseView = false
    
    @Binding var budgetData: BudgetInformation
    @Binding var expenseContainer: ExpenseContainer
    
    @EnvironmentObject var appViewModel: AppViewModel
    
    let textColor: Color = Color(red: 0.15, green: 0.15, blue: 0.15)
    
    
    var body: some View {
        ZStack {
            List{
                Section {
                    ForEach($expenseContainer.expenses){$expense in
                        HStack{
                            Button(action: {
                                isPresentingEditView = true
                                newExpenseData = expense.data
                                
                            }){
                                Image(systemName: "bag.circle.fill")
                                    .font(.callout)
                                    .labelStyle(.iconOnly)
                                    .foregroundColor(Color.accentColor)
                            }
                            
                            Text("\(expense.name): $\(expense.cost, specifier: "%.2f")")
                                .font(.subheadline)
                        }
                        .sheet(isPresented: $isPresentingEditView){
                            NavigationView{
                                ExpensesEditView(expenseData: $newExpenseData)
                                    .navigationTitle(expense.name)
                                    .toolbar {
                                        ToolbarItem(placement: .cancellationAction){
                                            Button("Cancel"){
                                                isPresentingEditView = false
                                            }
                                        }
                                        ToolbarItem(placement: .confirmationAction) {
                                            Button("Done"){
                                                isPresentingEditView = false
                                                
                                                expenseContainer.updateExpenseInfo(from: newExpenseData)
                                                budgetData.updateBudgetInfo(from: budgetData.data)
                                                appViewModel.user.updateAllIncome()
                                                appViewModel.updateUserData()
                                                
                                            }
                                        }
                                        
                                    }
                            }
                            
                        }
                    }
                }
            header: {
                HStack{
                    Label(expenseContainer.title, systemImage: "creditcard")
                        .foregroundStyle(textColor)
                        .font(.title3.bold())
                    
                    
                    Button(action: {isPresentingNewExpenseView = true}){
                        Label("Add", systemImage: "plus.circle.fill")
                            .font(.callout)
                            .labelStyle(.iconOnly)
                    }
                }
            }
                
            }
            .sheet(isPresented: $isPresentingNewExpenseView){
                NavigationView{
                    ExpensesEditView(expenseData: $newExpenseData)
                        .toolbar{
                            ToolbarItem(placement: .cancellationAction){
                                Button("Cancel"){
                                    isPresentingNewExpenseView = false
                                    newExpenseData = Expense.Data()
                                }
                            }
                            
                            
                            ToolbarItem(placement: .confirmationAction){
                                Button("Add"){
                                    let newExpense = Expense(data: newExpenseData)
                                    expenseContainer.expenses.append(newExpense)
                                    expenseContainer.updateExpenseInfo(from: newExpenseData)
                                    budgetData.updateBudgetInfo(from: budgetData.data)
                                    
                                    appViewModel.user.updateAllIncome()
                                    appViewModel.updateUserData()
                                    isPresentingNewExpenseView = false
                                    newExpenseData = Expense.Data()
                                }
                            }
                        }
                }
            }
            
        }
    }
    
}

struct ExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesView(budgetData: .constant(BudgetInformation.sampleData),
                     expenseContainer: .constant(User.sampleUser.expenseContainers[0]))
        .environmentObject(AppViewModel())
    }
}
