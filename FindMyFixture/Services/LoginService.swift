//
//  LoginService.swift
//  FindMyFixture
//
//  Created by Student on 09.06.21.
//

import Foundation
import SwiftUI


class LoginService {
    
    private var loginSucces: Bool = false
    
    public func userLogin(username: String, password: String, completion: @escaping (_ loginSucces: Bool, _ message: String, _ userId: Int) -> Void) {
        ApiService.shared.getLoginResponse(username: username, password: password) { result in
            switch result {
            case .success(let response):
                guard let loginData = response.first else { return }
                if loginData.state == "3" {
                    self.loginSucces = true
                } else {
                    self.loginSucces = false
                }
                completion(self.loginSucces, loginData.message, Int(loginData.userId) ?? 0)
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
 
}
