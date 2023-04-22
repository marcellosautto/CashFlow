//
//  RealExpenseContainerPicker.swift
//  CashFlow
//
//  Created by Marcello Sautto on 6/13/22.
//

import SwiftUI

struct RealExpenseContainerPicker: View {
    let containers: [ExpenseContainer]
    @Binding var containerIndex: Int
    
    var body: some View {
        Picker("", selection: $containerIndex){
            ForEach(Array(containers.enumerated()), id: \.offset){index, container in
                RealExpenseContainerPickerView(container: container).tag(index)
            }
        }
    }
}

struct RealExpenseContainerPicker_Previews: PreviewProvider {
    static var previews: some View {
        RealExpenseContainerPicker(containers: ExpenseContainer.sampleData, containerIndex: .constant(0))
    }
}
