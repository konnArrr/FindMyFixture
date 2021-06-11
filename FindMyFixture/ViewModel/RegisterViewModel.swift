//
//  RegisterViewModel.swift
//  FindMyFixture
//
//  Created by Student on 10.06.21.
//

import Foundation


class RegisterViewModel: ObservableObject {
    
    private let registerService = UserRegisterService()
    
    @Published var message: String = ""
    
    public func registerUser(userName: String, password: String) {
        registerService.registerUser(username: userName, password: password) { (msg) in
            self.message = msg
        }
    }
    
}
