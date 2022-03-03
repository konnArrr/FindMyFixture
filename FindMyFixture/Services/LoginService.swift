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
    
    public func userLogin(data: LoginBodyDataModel, completion: @escaping (_ loginSucces: Bool, _ message: String, _ userId: Int) -> Void) {
        ApiService.shared.getLoginResponse(by: data) { result in
            switch result {
            case .success(let loginData):
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
