//
//  ContentView.swift
//  FindMyFixture
//
//  Created by Student on 09.06.21.
//

import SwiftUI

struct ContentView: View {
    
    let loginService = LoginService()
    let userLoader = UserLoader()
    let registerService = UserRegisterService()
    
    
    
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {
//                loginService.userLogin(username: "gue", password: "ads") { (success, msg, uid) in
//                    print("succes: \(success)")
//                    print("msg: \(msg)")
//                    print("uid: \(uid)")
//                }
                
                userLoader.getUserBy(userId: 16) { (user) in
                    print("\(user)")
                }
//                registerService.registerUser(username: "bärbel", password: "bärbel") { (string) in
//                    print("\(string)")
//                }
                // print("userIsIn: \(loginService.userIsIn)")
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
