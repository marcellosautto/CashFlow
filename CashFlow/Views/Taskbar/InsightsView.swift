//
//  InsightsView.swift
//  CashFlow
//
//  Created by Marcello Sautto on 6/26/22.
//

import SwiftUI

struct InsightsView: View {
    
    @EnvironmentObject var appViewModel: AppViewModel
    var budgetExpenseDifference: Float = 0
    
    let bgColor: Color = Color(red: 0.94, green: 0.94, blue: 0.94)
    
    
    var body: some View {
        ZStack{
            bgColor.ignoresSafeArea(edges: .all)
            
            VStack(spacing: 10){
                Text("Insights")
                    .font(.title)
                
                List{
                    ForEach(appViewModel.user.expenseContainers){container in
                        
                        Section(container.title){
                            ProgressView("\(appViewModel.getRealExpenseContainerDifference(container: container), format: .currency(code: "USD")) Remaining", value: appViewModel.getRealExpenseContainerDifference(container: container), total: container.total)
                                .accentColor(handleColorChange(frac: appViewModel.getRealExpenseContainerDifference(container: container) / container.total))
                        }
                    }
                }
            }
        }

    }
    
//    func getBudgetExpenseDifference(container: ExpenseContainer) -> Float{
//        return container.total-appViewModel.getRealExpenseContainerTotal(containerTitle: container.title)
//    }
    
    func handleColorChange(frac: Float) -> Color {
        switch(frac){
            
        case(0.50..<1):
            return Color.green
        case(0.30..<0.5):
            return Color.yellow
        case(0.15..<0.30):
            return Color.orange
        case(0..<0.15):
            return Color.red
        default:
            return Color.green
        }
        
    }
}

struct InsightsView_Previews: PreviewProvider {
    static var previews: some View {
        InsightsView()
            .environmentObject(AppViewModel())
    }
}
