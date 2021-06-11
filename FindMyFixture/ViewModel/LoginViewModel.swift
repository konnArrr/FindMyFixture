//
//  LoginViewModel.swift
//  FindMyFixture
//
//  Created by Student on 10.06.21.
//

import Foundation


class LoginViewModel: ObservableObject {
    
    private let loginService = LoginService()
    
    @Published var message: String = ""
    @Published var loginSuccess: Bool = false
    @Published var userId = 0
    
    
    public func login(username: String, password: String) {
        loginService.userLogin(username: username, password: password) { (loginState, msg, uId) in
            self.loginSuccess = loginState
            print("\(self.loginSuccess)")
            self.message = msg
            self.userId = uId
        }
    }
    
    
    
}
