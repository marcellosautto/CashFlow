import SwiftUI
import Firebase


struct SignUpView: View {
    
    @Binding var user: User
    
    @EnvironmentObject var authViewModel: AuthViewModel
    let bgColor: Color = Color(red: 0.451, green: 0.749, blue: 0.631) // #73bfa1
    
    let textFieldBgColor: Color = Color(red: 0.9, green: 0.9, blue: 0.9)
    
    var body: some View {
        VStack {
            
            Text("Create an Account")
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
                    
                    authViewModel.signUp(email: user.email, password: user.password)
                    
                }, label: {
                    Text("Sign Up")
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

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(user: .constant(User.sampleUser))
            .environmentObject(AuthViewModel())
    }
}
