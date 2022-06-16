import SwiftUI
import Firebase


struct SignUpView: View {
    
    @Binding var user: User
    
    @EnvironmentObject var viewModel: AppViewModel
    let bgColor: Color = Color(red: 0.9, green: 0.95, blue: 0.95)
    
    var body: some View {
        VStack {
            
            Label("Cash Flow", systemImage: "dollarsign.circle")
                .font(.title)
            
            VStack{
                TextField("Email Address", text: $user.email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(5.0)
                
                SecureField("Password", text: $user.password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(5.0)
                
                Button(action: {
                    
                    guard !user.email.isEmpty, !user.password.isEmpty else {
                        return
                    }
                    
                    //THROWING ERROR:  No ObservableObject of type AppViewModel found
                    viewModel.signUp(email: user.email, password: user.password)
                }, label: {
                    Text("Sign Up")
                        .frame(width: 200, height: 50)
                        .background(Color.green)
                        .foregroundColor(Color.black)
                        .cornerRadius(5.0)
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
    }
}
