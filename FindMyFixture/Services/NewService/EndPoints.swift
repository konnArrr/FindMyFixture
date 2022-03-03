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
        return Endpoint(path: FmfUrlPaths.getAllFixtures.rawValue, requestData: requestData)
    }
    
}


extension Endpoint where Kind == EndpointKinds.Public, Response == User {
    
    static func getUser(by bodyData: UserBodyDataModel) -> Self {
        let requestData = RequestDataModel(httpMethod: .POST, bodyData: bodyData)
        return Endpoint(path: FmfUrlPaths.getUserById.rawValue, requestData: requestData)
    }
    
}

extension Endpoint where Kind == EndpointKinds.Public, Response == LoginResponse {
    
    static func getLoginEndpoint(bodyData: LoginBodyDataModel) -> Self {
        let requestData = RequestDataModel(httpMethod: .POST, bodyData: bodyData)
        return Endpoint(path: FmfUrlPaths.loginPath.rawValue, requestData: requestData)
    }
    
}
