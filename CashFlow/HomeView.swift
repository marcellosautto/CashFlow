//
//  ContentView.swift
//  EasyB
//
//  Created by Marcello Sautto on 6/4/22.
//

import SwiftUI

struct HomeView: View {
    
    @State var newExpenseContainerData = ExpenseContainer.Data()
    @State var isPresentingNewExpenseCategoryView: Bool = false
    
    @Binding var budgetData: BudgetInformation
    
    let textColor: Color = Color(red: 0.15, green: 0.15, blue: 0.15)
    let bgColor: Color = Color(red: 0.9, green: 0.95, blue: 0.95)
    
    
    var body: some View {
        
        ZStack {
            bgColor.ignoresSafeArea(edges: .all)
            
            VStack {
//                Label("CashFlow", systemImage: "dollarsign.circle")
//                    .foregroundStyle(textColor)
//                    .font(.largeTitle.bold().italic())
//                    .padding()
                
                Label("\(Date.now, format: .dateTime.month(.wide).day())", systemImage: "calendar")
                    .font(.title)
                
                ZStack{
                    VisualizedIncomeView(budgetData: $budgetData)
                    
                    Text("$\(budgetData.remainingIncome, specifier: "%.2f")")
                        .foregroundStyle(textColor)
                        .font(.largeTitle)
                        .accessibilityLabel("Money remaining")
                    
                }
                
                List {
                    ForEach($budgetData.expenseContainers){$container in
                        NavigationLink(destination: ExpenseContainerView(budgetData: $budgetData, expenseContainerData: $container)){
                            CardView(expenseContainer: container)
                                .frame(maxWidth: .infinity)
                                
                        }
                        .listRowBackground(container.theme.mainColor)
                        
                        
                        
                    }
                    
                }
                .toolbar{
                    Button(action: {isPresentingNewExpenseCategoryView = true}){
                        Image(systemName: "plus")
                    }
                }
                
            }
            
        }
        .sheet(isPresented: $isPresentingNewExpenseCategoryView){
            NavigationView{
                ExpenseContainerEditView(newExpenseContainerData: $newExpenseContainerData )
                    .toolbar{
                        ToolbarItem(placement: .cancellationAction){
                            Button("Cancel"){
                                isPresentingNewExpenseCategoryView = false
                                newExpenseContainerData = ExpenseContainer.Data()
                            }
                        }
                        
                        ToolbarItem(placement: .confirmationAction){
                            Button("Add"){
                                let newContainer = ExpenseContainer(data: newExpenseContainerData)
                                budgetData.expenseContainers.append(newContainer)
                                budgetData.updateAllIncome()
                                isPresentingNewExpenseCategoryView = false
                                newExpenseContainerData = ExpenseContainer.Data()
                            }
                        }
                    }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView(budgetData: .constant(BudgetInformation.sampleData))
        }
        
    }
    
}
