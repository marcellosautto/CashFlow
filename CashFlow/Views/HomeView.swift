//
//  ContentView.swift
//  EasyB
//
//  Created by Marcello Sautto on 6/4/22.
//

import SwiftUI
import Firebase

struct HomeView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    @State var modifiedBudgetData = BudgetInformation.Data()
    @State var newExpenseContainerData = ExpenseContainer.Data()
    @State var isPresentingNewExpenseCategoryView: Bool = false
    @State var isPresentingEditBudgetView: Bool = false
    
    @Binding var budgetData: BudgetInformation
    
    let textColor: Color = Color(red: 0.15, green: 0.15, blue: 0.15)
    let bgColor: Color = Color(red: 0.94, green: 0.94, blue: 0.94)
    
    
    var body: some View {
        
        ZStack {
            bgColor.ignoresSafeArea(edges: .all)
            
            VStack {
                
                Label("\(Date.now, format: .dateTime.month(.wide).day())", systemImage: "calendar")
                    .font(.title)
                
                ZStack{
                    VisualizedIncomeView(budgetData: $budgetData)
                    
                    Text("$\(budgetData.remainingIncome, specifier: "%.2f")")
                        .foregroundStyle(textColor)
                        .font(.largeTitle)
                        .accessibilityLabel("Money remaining")
                    
                    VStack{
                        Spacer()
                            .frame(height: 130)
                        Button(action: {
                            isPresentingEditBudgetView = true
                        }, label: {
                            Text("Edit")
                                .font(.headline)
                        })
                    }
                    .sheet(isPresented: $isPresentingEditBudgetView){
                        NavigationView{
                            BudgetInformationEditView().environmentObject(viewModel)
                        }
                    }
                    
                    
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
                    
                    ToolbarItem{
                        ///toggles sheet for creating a new expense category
                        Button(action: {isPresentingNewExpenseCategoryView = true}){
                            Image(systemName: "plus")
                        }
                    }
                    
                    ToolbarItem(placement: .cancellationAction){
                        Button("Sign Out"){
                            viewModel.signOut()
                        }
                    }
                    
                    
                    
                }
                
            }
            
        }
        .sheet(isPresented: $isPresentingNewExpenseCategoryView){
            NavigationView{
                ExpenseContainerEditView(newExpenseContainerData: $newExpenseContainerData )
                    .toolbar{
                        ///return to home screen and dismiss any changes
                        ToolbarItem(placement: .cancellationAction){
                            Button("Cancel"){
                                isPresentingNewExpenseCategoryView = false
                                newExpenseContainerData = ExpenseContainer.Data()
                            }
                        }
                        
                        ///adds a new expense container
                        ToolbarItem(placement: .confirmationAction){
                            Button("Add"){
                                let newContainer = ExpenseContainer(data: newExpenseContainerData)
                                budgetData.expenseContainers.append(newContainer)
                                budgetData.updateBudgetInfo(from: budgetData.data)
                                
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