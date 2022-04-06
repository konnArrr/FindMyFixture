//
//  RegisterViewModel.swift
//  FindMyFixture
//
//  Created by Student on 10.06.21.
//

import Foundation

private let logger = Logger.getLogger(ApiService.self, level: .verbose)


class RegisterViewModel: ObservableObject {
    

    
    @Published var message: String = ""
    
    public func registerUser(userName: String, password: String, completion: @escaping (Bool) -> Void) {
        
        ApiService.shared.registerUser(by: LoginRegisterBodyDataModel(username: userName, password: password)) { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let registerData):
                DispatchQueue.main.async {
                    let state = registerData.state == "3"
                    logger.info("loginState: \(state)")
                    this.message = registerData.message
                    completion(true)
                }
            case .failure(let error):
                logger.error(error)
                completion(false)
            }
        }
        
    }
    
}
