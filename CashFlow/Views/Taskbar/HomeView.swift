//
//  ContentView.swift
//  EasyB
//
//  Created by Marcello Sautto on 6/4/22.
//

import SwiftUI
import Firebase

struct HomeView: View {
    
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var appViewModel: AppViewModel
    
    // @State var modifiedBudgetData = BudgetInformation.sampleData
    @State var newExpenseContainerData = ExpenseContainer.Data()
    @State var isPresentingNewExpenseCategoryView: Bool = false
    @State var isPresentingEditBudgetView: Bool = false
    
    let textColor: Color = Color(red: 0.15, green: 0.15, blue: 0.15)
    let bgColor: Color = Color(red: 0.94, green: 0.94, blue: 0.94)
    
    
    var body: some View {
        
        ZStack {
            bgColor.ignoresSafeArea(edges: .all)
            
            VStack {
                
                Label("\(Date.now, format: .dateTime.month(.wide).day().year())", systemImage: "calendar")
                    .font(.title)
                
                ZStack{
                    VisualizedIncomeView(budgetData: $appViewModel.user.budgetInformation)
                    
                    Text("$\(appViewModel.user.budgetInformation.remainingIncome, specifier: "%.2f")")
                        .foregroundStyle(textColor)
                        .font(.largeTitle)
                        .accessibilityLabel("Money remaining")
                    
                    VStack{
                        Spacer()
                            .frame(height: 130)
                        Button(action: {
                            isPresentingEditBudgetView = true
                            //modifiedBudgetData = appViewModel.user.budgetInformation
                        }, label: {
                            Text("Edit")
                                .font(.headline)
                        })
                    }
                    .sheet(isPresented: $isPresentingEditBudgetView){
                        NavigationView{
                            BudgetInformationEditView(budgetData: $appViewModel.user.budgetInformation)
                                .toolbar{
                                    
                                    ToolbarItem(placement: .cancellationAction){
                                        Button("Cancel"){
                                            isPresentingEditBudgetView = false
                                        }
                                    }
                                    
                                    ToolbarItem(placement: .confirmationAction){
                                        Button("Done"){
                                            appViewModel.user.budgetInformation.updateBudgetInfo(from: appViewModel.user.budgetInformation.data)
                                            appViewModel.user.updateAllIncome()
                                            appViewModel.updateUserData()
                                            
                                            //modifiedBudgetData = appViewModel.user.budgetInformation
                                            isPresentingEditBudgetView = false
                                        }
                                        
                                    }
                                    
                                    
                                    
                                }
                        }
                        
                    }
                    
                    
                }
                
                
                List {
                    
                    ///toggles sheet for creating a new expense category
                    HStack{
                        Spacer()
                        Text("Categories")
                            .font(.title3)
                            .padding(.leading)
                        Spacer()
                        
                        Button(action: {isPresentingNewExpenseCategoryView = true}){
                            
                            Image(systemName: "plus")
                                .padding(.trailing)
                        }
                        
                        
                    }
                    .listRowBackground(Color(red: 0.65, green: 0.65, blue: 0.65))
                    .foregroundColor(Color.white)
                    
                    
                    
                    ForEach($appViewModel.user.expenseContainers){ $container in
                        NavigationLink(destination: ExpenseContainerView(budgetData: $appViewModel.user.budgetInformation, expenseContainerData: $container)
                            .environmentObject(appViewModel))
                        {
                            CardView(expenseContainer: container)
                                .frame(maxWidth: .infinity)
                            
                        }
                        .listRowBackground(container.theme.mainColor)
                        
                        
                        
                        
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
                                appViewModel.user.expenseContainers.append(newContainer)
                                appViewModel.user.budgetInformation.updateBudgetInfo(from: appViewModel.user.budgetInformation.data)
                                
                                
                                appViewModel.updateUserData()
                                
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
            HomeView()
                .environmentObject(AuthViewModel())
                .environmentObject(AppViewModel())
        }
        
    }
    
}
