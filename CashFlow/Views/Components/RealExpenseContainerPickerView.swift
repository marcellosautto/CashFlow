//
//  ThemeView.swift
//  CashFlow
//
//  Created by Marcello Sautto on 6/13/22.
//

import SwiftUI

struct RealExpenseContainerPickerView: View {
    let container: ExpenseContainer
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 4)
                .fill(container.theme.mainColor)
            Label(container.title, systemImage: "archivebox")
                .padding(4)
        }
        .foregroundColor(container.theme.accentColor)
        .fixedSize(horizontal: false, vertical: true)
    }
}

struct RealExpenseContainerPickerView_Previews: PreviewProvider {
    static var previews: some View {
        RealExpenseContainerPickerView(container: ExpenseContainer.sampleData[0])
    }
}
