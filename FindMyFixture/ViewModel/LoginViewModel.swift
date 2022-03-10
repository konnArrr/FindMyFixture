//
//  LoginViewModel.swift
//  FindMyFixture
//
//  Created by Student on 10.06.21.
//

import Foundation

private let logger = Logger.getLogger(ApiService.self, level: .verbose)


class LoginViewModel: ObservableObject {
    
    @Published var message: String = ""
    @Published var loginSuccess: Bool = false
    @Published var userId = 0
    
    
    public func login(username: String, password: String, completion: @escaping (Bool) -> Void) {
        ApiService.shared.getLoginResponse(by: LoginBodyDataModel(username: username, password: password)) { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let loginData):
                DispatchQueue.main.async {
                    this.loginSuccess = loginData.state == "3"
                    logger.info("loginState: \(this.loginSuccess)")
                    this.message = loginData.message
                    this.userId = Int(loginData.userId) ?? 0
                    completion(true)
                }
            case .failure(let error):
                logger.error(error)
                completion(false)
            }
        }
    }
    
    
    
}
