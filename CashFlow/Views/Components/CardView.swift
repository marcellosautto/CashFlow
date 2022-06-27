//
//  CardView.swift
//  CashFlow
//
//  Created by Marcello Sautto on 6/14/22.
//

import SwiftUI

struct CardView: View {
    
    let expenseContainer: ExpenseContainer
    
    var body: some View {
        VStack{
            Label(expenseContainer.title, systemImage: "banknote")
                .font(.headline)
            Text(expenseContainer.description)
                .font(.caption)
            Spacer()
            HStack{
                Text("Total: $\(expenseContainer.total, specifier: "%.2f")")
                    .font(.caption)
                Spacer()
                Text("\(expenseContainer.relativeTotal, specifier: "%.2f")%")
                    .font(.caption)
            }
            .padding(.horizontal)
            
        }
        .foregroundColor(expenseContainer.theme.accentColor)
    }
}

struct CardView_Previews: PreviewProvider {
    
    static let expenseContainer: ExpenseContainer = User.sampleUser.expenseContainers[0]
    
    static var previews: some View {
        CardView(expenseContainer: expenseContainer)
            .previewLayout(.fixed(width: 400, height: 60))
            .frame(maxWidth: .infinity)
            .background(expenseContainer.theme.mainColor)
            
    }
}
