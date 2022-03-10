//
//  ApiService.swift
//  FindMyFixture
//
//  Created by Konstantin Schirmer on 23.02.22.
//

import Foundation

extension ApiService {
    

    
    public func loadUser(by data: UserBodyDataModel, completion: @escaping (Result<User, Error>) -> Void) {
        let endPoint = Endpoint<EndpointKinds.Public, User>.getUser(by: data)
        loadModel(endPoint: endPoint, completion: completion)
    }
    
    
    public func getLoginResponse(by data: LoginBodyDataModel, completion:  @escaping (Result<LoginResponse, Error>) -> Void) {
        loadModel(endPoint: Endpoint<EndpointKinds.Public, LoginResponse>.getLoginEndpoint(bodyData: data), completion: completion)
    }
    
    public func registerUser(by data: LoginBodyDataModel, completion: @escaping (Result<PhpResponse, Error>) -> Void) {
        loadModel(endPoint: Endpoint<EndpointKinds.Public, PhpResponse>.getRegisterEndpoint(bodyData: data), completion: completion)
    }
    
    public func getAllFixtures(completion: @escaping (Result<[Fixture], Error>) -> Void) {
        loadModel(endPoint: Endpoint<EndpointKinds.Public, [Fixture]>.getAllFixtures(), completion: completion)
    }
    
    public func addFixture(by data: Fixture, completion: @escaping (Result<PhpResponse, Error>) -> Void) {
        loadModel(endPoint: Endpoint<EndpointKinds.Public, PhpResponse>.getAddFixtureEndpoint(bodyData: data), completion: completion)
    }
    
}
