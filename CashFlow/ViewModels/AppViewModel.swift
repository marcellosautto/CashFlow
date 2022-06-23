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
    
    @Published var budgetInformation = BudgetInformation(data: BudgetInformation.sampleData.data)
    @Published var expenseContainers = [ExpenseContainer]()
    
    let auth = Auth.auth()
    let dbref = Database.database().reference()
    
    
    init(){
        importUserData()
    }
    
    
    //MARK: ON LOAD HANDLER
    
    func importUserData(){
        
        //let budgetInfoCollection = db.collection("users").document(User.sampleUser.id).collection("budgetinformation")
        //getBudgetInformation(budgetInfoCollection: budgetInfoCollection)
        
        dbref.child("users/\(auth.currentUser!.uid)").getData(completion:  { error, snapshot in
          guard error == nil else {
            print(error!.localizedDescription)
            return;
          }
            let data = snapshot?.value as? NSDictionary
            let budgetInfoObject = data?["budgetInformation"] as? NSDictionary //budget information
            let expenseContainerObject = data?["expenseContainers"] as? NSArray //expense containers
            
            //print(budgetInfoObject)
            //print(expenseContainerObject)
            
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
            
            
        });
        
        print(budgetInformation)
        print(expenseContainers)
        
        
    }
    
    

    
}
