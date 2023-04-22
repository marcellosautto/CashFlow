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
    
    let textColor: Color = Color(red: 0.10, green: 0.10, blue: 0.10)
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
                
                ///toggles sheet for creating a new expense category
                HStack{
                    Spacer()
                    Text("Categories")
                        .font(.title3)
                        .padding()
                        .padding(.leading, 50)
                    Spacer()
                    
                    Button(action: {isPresentingNewExpenseCategoryView = true}){
                        
                        Image(systemName: "plus.circle")
                    }
                    .padding(.horizontal)
                    
                    
                }
                .background(Color(red: 0.81, green: 0.76, blue: 0.65))
                //.border(Color(red: 0.35, green: 0.35, blue: 0.35))
                .cornerRadius(5)
                .padding(.horizontal)
                .foregroundColor(textColor)
                
                List {
                    
                    
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
