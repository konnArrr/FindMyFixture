//
//  RegisterView.swift
//  FindMyFixture
//
//  Created by Student on 10.06.21.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject var viewModel = RegisterViewModel()
    
    @State var username: String = ""
    @State var password: String = ""
    @State var passwordRepeat: String = ""
    
    
//    @Binding var email: String
//    @Binding var classname: String
//    @Binding var responseText: String
//    @Binding var loginOrRegister: Bool
    

    
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Color.green
                    .frame(width: 180, height: 180)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10.0, x: 20, y: 10)
                Image(systemName: "person")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120 , height: 120)
            }
            Spacer()
            VStack(alignment: .leading, spacing: 15) {
                TextField("username", text: $username)
                    .disableAutocorrection(true)
                    .padding()
                    .background(Color.themeTextField)
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
                SecureField("password", text: $password)
                    .textContentType(.none)
                    .disableAutocorrection(true)
                    .padding()
                    .background(Color.themeTextField)
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
                SecureField("password repeat", text: $passwordRepeat)
                    .textContentType(.none)
                    .disableAutocorrection(true)
                    .padding()
                    .background(Color.themeTextField)
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
                
            }
            .padding([.leading, .trailing], 27.5)
//            .onAppear {
//                username = ""
//                password = ""
//                email = ""
//            }
            Text("\(viewModel.message)")
                .multilineTextAlignment(.center)
                .font(.title2)
            
            Button(action: {
                if (self.password == self.passwordRepeat) {
                    viewModel.registerUser(userName: username, password: password)
                } else {
                    viewModel.message = "passwords do not match"
                }
                
            }) {
                Text("Register")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.green)
                    .cornerRadius(15.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
            }.padding(.top, 50)
            .disabled((self.username.isEmpty || self.password.isEmpty || self.passwordRepeat.isEmpty))
            
            
            Spacer()
//            HStack(spacing: 0) {
//                Text("You have an account? ")
//                Button(action: {
//                    self.loginOrRegister = true
//                }) {
//                    Text("Sign In")
//                        .foregroundColor(.blue)
//                }
//            }
            
            
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all))
    }
    
//    private func checkTextFieldEmpty() -> Bool {
//        // || password.isEmpty || email.isEmpty
//        if classname.isEmpty {
//            return true
//        } else {
//            return false
//        }
//    }
}




