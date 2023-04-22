//
//  CardView.swift
//  CashFlow
//
//  Created by Marcello Sautto on 6/14/22.
//

import SwiftUI

struct RealExpenseCardView: View {
    
    let realExpense: RealExpense
    
    var body: some View {
        VStack{
            HStack{
                Label(realExpense.name, systemImage: "dollarsign.square")
                    .font(.headline)
                Spacer()
                Text("\(realExpense.cost, format: .currency(code: "USD"))")
                    .font(.headline)
                
            }
            .padding(.horizontal)
            
            HStack{
//                Label(realExpense.container, systemImage: "archivebox")
//                    .font(.caption)
                Spacer()
                Text("\(realExpense.date, format: .dateTime.month(.wide).day().year())")
                    .font(.caption)
                
                
                
            }.padding(.horizontal)
        }
        .frame(width: 300, height: 60, alignment: .center)
        .background(realExpense.containerDescriptor.theme.mainColor)
        .foregroundColor(realExpense.containerDescriptor.theme.accentColor)
    }
}

struct RealExpenseCardView_Previews: PreviewProvider {
    
    static let realExpense: RealExpense = RealExpense.sampleData[0]
    
    static var previews: some View {
        RealExpenseCardView(realExpense: realExpense)
            .previewLayout(.fixed(width: 300, height: 60))
            //.frame(maxWidth: .infinity)
            .background(realExpense.containerDescriptor.theme.mainColor)
        
    }
}
