//
//  ThemePicker.swift
//  CashFlow
//
//  Created by Marcello Sautto on 6/13/22.
//

import SwiftUI

struct ThemePicker: View {
    @Binding var selection: Theme
    
    var body: some View {
        Picker("", selection: $selection){
            ForEach(Theme.allCases){theme in
                ThemeView(theme: theme)
                    .tag(theme)
            }
        }
    }
}

struct ThemePicker_Previews: PreviewProvider {
    static var previews: some View {
        ThemePicker(selection: .constant(.bubblegum))
    }
}
