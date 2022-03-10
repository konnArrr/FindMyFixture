//
//  EndPoints.swift
//  FindMyFixture
//
//  Created by Konstantin Schirmer on 23.02.22.
//

import Foundation


extension Endpoint where Kind == EndpointKinds.Public, Response == [Fixture] {
    
    static func getAllFixtures() -> Self {
        let requestData = RequestDataModel(httpMethod: .GET)
        return Endpoint(path: UrlEndPaths.getAllFixtures.rawValue, requestData: requestData)
    }
    
}


extension Endpoint where Kind == EndpointKinds.Public, Response == User {
    
    static func getUser(by bodyData: UserBodyDataModel) -> Self {
        let requestData = RequestDataModel(httpMethod: .POST, bodyData: bodyData)
        return Endpoint(path: UrlEndPaths.getUserById.rawValue, requestData: requestData)
    }
    
}

extension Endpoint where Kind == EndpointKinds.Public, Response == LoginResponse {
    
    static func getLoginEndpoint(bodyData: LoginBodyDataModel) -> Self {
        let requestData = RequestDataModel(httpMethod: .POST, bodyData: bodyData)
        return Endpoint(path: UrlEndPaths.loginPath.rawValue, requestData: requestData)
    }
    
}

extension Endpoint where Kind == EndpointKinds.Public, Response == PhpResponse {
    static func getRegisterEndpoint(bodyData: LoginBodyDataModel) -> Self {
        let requestData = RequestDataModel(httpMethod: .POST, bodyData: bodyData)
        return Endpoint(path: UrlEndPaths.registerPath.rawValue, requestData: requestData)
    }
}


extension Endpoint where Kind == EndpointKinds.Public, Response == PhpResponse {
    static func getAddFixtureEndpoint(bodyData: Fixture) -> Self {
        let requestData = RequestDataModel(httpMethod: .POST, bodyData: bodyData)
        return Endpoint(path: UrlEndPaths.addFixturePath.rawValue, requestData: requestData)
    }
}
