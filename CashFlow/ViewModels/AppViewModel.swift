//
//  AppViewModel.swift
//  CashFlow
//
//  Created by Marcello Sautto on 6/15/22.
//

import SwiftUI
import Firebase

class AppViewModel: ObservableObject {
    
    //MARK: AUTHENTICATION
    
    @Published var signedIn = false
    
    let auth = Auth.auth()
    let db = Firestore.firestore()
    
    init(){
        importUserData()
    }
    
    var isSignedIn: Bool{
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String){
        auth.signIn(withEmail: email, password: password) {
            [weak self] result, error in
            guard result != nil, error == nil else{
                return
            }
            
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    
    func signUp(email: String, password: String){
        auth.createUser(withEmail: email, password: password) {
            [weak self] result, error in
            guard result != nil, error == nil else{
                return
            }
            
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
        
        db.collection("users").addDocument(data:["email":email, "password": password])
    }
    
    func signOut() {
        try? auth.signOut()
        
        self.signedIn = false
    }
    
    //MARK: ON LOAD HANDLER
    
    let loadDataQueue = OperationQueue()
    
    func importUserData(){
        
        let budgetInfoCollection = db.collection("users").document(User.sampleUser.id).collection("budgetinformation")
        getBudgetInformation(budgetInfoCollection: budgetInfoCollection)
        
//        let budgetInfoOperation = BudgetInformationImportOperation(budgetInformationCollection: budgetInfoCollection)
//        let expenseContainerOperation = Operation()
//        let expensesOperation = Operation()
//
//        budgetInfoOperation.addDependency(expenseContainerOperation)
//        expenseContainerOperation.addDependency(expensesOperation)
//
//        loadDataQueue.addOperations([budgetInfoOperation, expenseContainerOperation, expensesOperation], waitUntilFinished: true)
//
//        budgetInfoOperation.completionBlock = {
//            print("budget info import complete")
//        }
//
//        expenseContainerOperation.completionBlock = {
//            print("expense container import complete")
//        }
//
//        expensesOperation.completionBlock = {
//            print("expenses import complete")
//        }
    }
    
    
    //MARK: BUDGET INFORMATION
    
    @Published var budgetInformation = [BudgetInformation]()
    @Published var expenseContainers = [ExpenseContainer]()
    @Published var expenses = [Expense]()
    
    let queue = DispatchQueue(label: "com.cashflow.queue", attributes: .concurrent)
    
    
    func getBudgetInformation(budgetInfoCollection: CollectionReference){
        
        //let budgetInfoCollection = db.collection("users").document(User.sampleUser.id).collection("budgetinformation")
        
        //var expenseContainers = [ExpenseContainer]()
        
        budgetInfoCollection.getDocuments { snapShot, error in
            if error == nil {
                DispatchQueue.main.async { //[weak self] in
                    
                    self.budgetInformation = snapShot!.documents.map { doc in
                        
                        self.getExpenseContainers(expenseContainerCollection: doc["expenseContainers"] as? CollectionReference ?? budgetInfoCollection.document(doc.documentID).collection("expenseContainers"))
                        
                                            
                        return BudgetInformation(yearlyIncome: doc["yearlyIncome"] as? Float ?? 0, isGrossIncome: Bool(doc["isGrossIncome"] as? String ?? "true")!, expenseContainers: self.expenseContainers)
                    }
                    
                    print("budget information")
                }
            }
        }
        
    }
    
    
    
    
    func getExpenseContainers(expenseContainerCollection: CollectionReference){
        
        
        expenseContainerCollection.getDocuments { snapShot, error in
            if error == nil {
                DispatchQueue.main.async {
                    self.expenseContainers = snapShot!.documents.map { doc in
                        
                       self.getExpenses(expenseCollection: doc["expenses"] as? CollectionReference ?? expenseContainerCollection.document(doc.documentID).collection("expenses"))
                        
                       //  repeat{}while(self.expenses.isEmpty) //replace with a delay that doesnt crash the app
                        
                        return ExpenseContainer(title: doc["title"] as? String ?? "", description: doc["description"] as? String ?? "", expenses: self.expenses, theme: Theme(rawValue: doc["theme"] as? String ?? "")!)
                    }
                    print("expense containers")
                }
                
            }
        }
        
    }
    
    func getExpenses(expenseCollection: CollectionReference){
        
        
        expenseCollection.getDocuments { snapShot, error in
            if error == nil {
                DispatchQueue.main.async { //[weak self] in
                    
                    self.expenses = snapShot!.documents.map { doc in
                        
                        return Expense(name: doc["name"] as? String ?? "", cost: doc["cost"] as? Float ?? 0)
                    }
                    
                    print("expenses")
                }
            }
            
        }
        
    }
    
}
