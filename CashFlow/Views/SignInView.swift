//
//  SignInView.swift
//  CashFlow
//
//  Created by Marcello Sautto on 6/15/22.
//

import SwiftUI
import Firebase


struct SignInView: View {
    
    @Binding var user: User
    
    @EnvironmentObject var viewModel: AppViewModel
    
    let bgColor: Color = Color(red: 0.9, green: 0.95, blue: 0.95)
    let textFieldBgColor: Color = Color(red: 0.6, green: 0.6, blue: 0.6)
    
    
    var body: some View {
        VStack {
            Label("Cash Flow", systemImage: "dollarsign.circle")
                .font(.title)
            
            VStack{
                TextField("Email Address", text: $user.email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(textFieldBgColor)
                    .cornerRadius(5.0)
                
                SecureField("Password", text: $user.password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(textFieldBgColor)
                    .cornerRadius(5.0)
                
                Button(action: {
                    
                    guard !user.email.isEmpty, !user.password.isEmpty else {
                        return
                    }
                    
                    viewModel.signIn(email: user.email, password: user.password)
                }, label: {
                    Text("Sign In")
                        .frame(width: 200, height: 50)
                        .background(Color.green)
                        .foregroundColor(Color.black)
                        .cornerRadius(5.0)
                })
                
                NavigationLink("Create Account", destination: SignUpView(user: $user).environmentObject(viewModel))
                    .padding()
            }
            .padding()
            
            Spacer()
            
        }
        .padding()
        .background(bgColor)
        
        
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(user: .constant(User.sampleUser))
    }
}
