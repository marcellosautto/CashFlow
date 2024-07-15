//
//  SignInView.swift
//  CashFlow
//
//  Created by Marcello Sautto on 6/15/22.
//

import SwiftUI
import Firebase


struct SignInView: View {
    
    //@Binding var user: User
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    let bgColor: Color = Color(red: 0.451, green: 0.749, blue: 0.631) // #73bfa1
    let textFieldBgColor: Color = Color(red: 0.9, green: 0.9, blue: 0.9)
    let errorMsgColor: Color = Color(red: 1.0, green: 0, blue: 0)
    
    
    var body: some View {
        VStack {
            Image("cashflow-logo-title")
                .resizable()
                .frame(width: 325, height: 325)
            
            VStack{
                TextField("Email Address", text: $authViewModel.user.email, prompt: Text("Email"))
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(textFieldBgColor)
                    .cornerRadius(5.0)
                
                SecureField("Password", text: $authViewModel.user.password, prompt: Text("Password"))
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(textFieldBgColor)
                    .cornerRadius(5.0)
                
                Label("Email or password is incorrect", systemImage: "exclamationmark.triangle")
                    .foregroundColor(errorMsgColor)
                    .opacity(authViewModel.errIsActive)
                    .frame(width: 320, height: authViewModel.errHeight, alignment: .leading)
                
                NavigationLink("Forgot Password?", destination: ResetPasswordView().environmentObject(authViewModel))
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    .frame(width: 320, height: 20, alignment: .leading)
                
                Spacer()
                
                NavigationLink {
                    SignUpView().environmentObject(authViewModel)
                } label: {
                    Text("Sign Up")
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(10.0)
                }
                
                Button(action: {
                    
                    guard !authViewModel.user.email.isEmpty, !authViewModel.user.password.isEmpty
                    else {
                        return
                    }
                    
                    authViewModel.signIn(email: authViewModel.user.email, password: authViewModel.user.password)
                }, label: {
                    Text("Sign In")
                        .frame(width: 200, height: 50)
                        .background(Color.black)
                        .foregroundColor(Color.white)
                        .cornerRadius(10.0)
                })
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
        SignInView()
            .environmentObject(AuthViewModel())
    }
}
