//
//  AppViewModel.swift
//  CashFlow
//
//  Created by Marcello Sautto on 6/15/22.
//

import SwiftUI
import Firebase
import FirebaseDatabase

class AppViewModel: ObservableObject {
    
    @Published var user = User(data: User.sampleUser.data)
    @Published var budgetInformation = BudgetInformation(data: BudgetInformation.sampleData.data)
    @Published var expenseContainers = [ExpenseContainer]()
    
    let auth = Auth.auth()
    let dbref = Database.database().reference()
    
    
    init(){
        
        guard auth.currentUser != nil else {
            print("Error: current user not found")
            return
        }
        
        importUserData()
    }
    
    
    //MARK: ON LOAD HANDLER
    
    func initializeNewUserData(){
        
        dbref.child("users/\(auth.currentUser!.uid)").getData(completion:  { error, snapshot in
          guard error == nil else {
            print(error!.localizedDescription)
            return
          }
        })
    }
    
    func updateUserData(){
        
    }
    
    func deleteUserData(){
        
    }
    
    func importUserData(){
        
        dbref.child("users/\(auth.currentUser!.uid)").getData(completion:  { error, snapshot in
          guard error == nil else {
            print(error!.localizedDescription)
            return;
          }
            let data = snapshot?.value as? NSDictionary
            
            self.setUserData(data: data)
        });
        
        
    }
    
    func setUserData(data: NSDictionary?){
        let budgetInfoObject = data?["budgetInformation"] as? NSDictionary //budget information
        let expenseContainerObject = data?["expenseContainers"] as? NSArray //expense containers
        
        
        self.budgetInformation = BudgetInformation(yearlyIncome: budgetInfoObject?["yearlyIncome"] as? Float ?? 0, isGrossIncome: budgetInfoObject?["isGrossIncome"] as? Bool ?? true)
        
        for container_key in 0..<expenseContainerObject!.count {

            let container = expenseContainerObject?[container_key] as? NSDictionary //current expense container

            
            let expenses = container?["expenses"] as? NSArray //expenses in current container
            var expensesAsClassObject = [Expense]() //array of expense objects

            for expense_key in 0..<expenses!.count{

                let expense = expenses?[expense_key] as? NSDictionary //expense array

                expensesAsClassObject.append(Expense(name: expense?["name"] as? String ?? "", cost: expense?["cost"] as? Float ?? 0))

            }

            self.expenseContainers.append(ExpenseContainer(title: container?["title"] as? String ?? "", description: container?["description"] as? String ?? "", expenses: expensesAsClassObject, theme: Theme(rawValue: container?["theme"] as? String ?? "indigo")!))


        }
        
        self.user = User(id: auth.currentUser!.uid, email: data?["email"] as? String ?? "guest", password: data?["password"] as? String ?? "guest", budgetInformation: self.budgetInformation, expenseContainers: self.expenseContainers)
    }
    
    

    
}
