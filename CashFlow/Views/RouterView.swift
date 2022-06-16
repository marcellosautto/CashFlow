//
//  RouterView.swift
//  CashFlow
//
//  Created by Marcello Sautto on 6/15/22.
//

import SwiftUI
import Firebase

struct RouterView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    @Binding var budgetData: BudgetInformation
    @Binding var user: User
    
    var body: some View {
        NavigationView{
            if viewModel.isSignedIn {
                HomeView(budgetData: $budgetData)
                    .environmentObject(viewModel)
            }
            else{
                SignInView(user: $user)
                    .environmentObject(viewModel)
            }
        }
        .onAppear{
            viewModel.signedIn = viewModel.isSignedIn  
        }

    }
}

struct RouterView_Previews: PreviewProvider {
    static var previews: some View {
        RouterView(budgetData: .constant(BudgetInformation.sampleData), user: .constant(User.sampleUser))
    }
}
