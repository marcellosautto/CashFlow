//
//  VisualizedIncomeView.swift
//  EasyB
//
//  Created by Marcello Sautto on 6/4/22.
//

import SwiftUI

struct VisualizedIncomeView: View {
    
    @Binding var budgetData: BudgetInformation
    
    var body: some View {
        ZStack{
            Circle()
                .stroke(lineWidth: 20)
                .opacity(0.3)
                .foregroundColor(handleColorChange(frac: budgetData.remainingIncomeFraction))
                .padding()
            
            Circle()
                .trim(from: 0.0, to: CGFloat(budgetData.remainingIncomeFraction))
                .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                .foregroundColor(handleColorChange(frac: budgetData.remainingIncomeFraction))
                .rotationEffect(Angle(degrees: 270))
                .padding()
        }
    }
    
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

struct VisualizedIncomeView_Previews: PreviewProvider {
    static var previews: some View {
        VisualizedIncomeView(budgetData: .constant(BudgetInformation.sampleData))
    }
}
