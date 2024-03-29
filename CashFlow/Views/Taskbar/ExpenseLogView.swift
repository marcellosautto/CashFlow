//
//  ExpenseLogView.swift
//  CashFlow
//
//  Created by Marcello Sautto on 6/27/22.
//

import SwiftUI

struct ExpenseLogView: View {
    
    //@State private var loggedExpenses: [RealExpense] = [RealExpense]()
    @State var containerIndex: Int = 0
    @State var newExpense = RealExpense.Data()
    @State var isPresentingAddRealExpenseSheet = false
    
    
    @EnvironmentObject var appViewModel: AppViewModel
    
    var body: some View {
        NavigationView {
            
            VStack{
                
                List(appViewModel.user.realExpenses) { expense in
                    RealExpenseCardView(realExpense: expense)
                        .listRowBackground(expense.containerDescriptor.theme.mainColor)
                    
                }
            }
            .navigationTitle("Expense Log")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {isPresentingAddRealExpenseSheet = true}){
                        Label("Add Expense", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $isPresentingAddRealExpenseSheet){
                NavigationView{
                    ExpenseLogEditView(realExpense: $newExpense, containerIndex: $containerIndex)
                        .environmentObject(appViewModel)
                        .toolbar{
                            ToolbarItem(placement: .cancellationAction){
                                Button("Cancel"){
                                    isPresentingAddRealExpenseSheet = false
                                }
                            }
                            
                            ToolbarItem(placement: .confirmationAction){
                                Button("Done"){
                                    var newExpense = RealExpense(data: newExpense)
                                    
                                    newExpense.containerDescriptor.title = appViewModel.user.expenseContainers[containerIndex].title
                                    
                                    newExpense.containerDescriptor.theme = appViewModel.user.expenseContainers[containerIndex].theme
                                    
                                    
                                    appViewModel.user.realExpenses.append(newExpense)
                                    appViewModel.updateUserData()
                                    self.newExpense = RealExpense.Data()
                                    isPresentingAddRealExpenseSheet = false
                                    
                                }
                            }
                        }
                }
            }
        }
    }
}

struct ExpenseLogView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseLogView()
            .environmentObject(AppViewModel())
    }
}
