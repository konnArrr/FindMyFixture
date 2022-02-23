//
//  ApiService.swift
//  FindMyFixture
//
//  Created by Konstantin Schirmer on 23.02.22.
//

import Foundation

extension ApiService {
    

    
    public func loadUser(by id: String, completion: @escaping (Result<[User], Error>) -> Void) {
        let endPoint = Endpoint<EndpointKinds.Public, [User]>.getUser(by: id)
        loadModel(endPoint: endPoint, completion: completion)
    }
    
    public func getAllFixtures(completion: @escaping (Result<[Fixture], Error>) -> Void) {
        loadModel(endPoint: Endpoint<EndpointKinds.Public, [Fixture]>.getAllFixtures(), completion: completion)
    }
    
    public func getLoginResponse(username: String, password: String, completion:  @escaping (Result<[LoginResponse], Error>) -> Void) {
        loadModel(endPoint: Endpoint<EndpointKinds.Public, [LoginResponse]>.getLoginEndpoint(username: username, password: password), completion: completion)
    }
    
    
}
