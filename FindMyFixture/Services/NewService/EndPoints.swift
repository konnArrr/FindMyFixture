//
//  EndPoints.swift
//  FindMyFixture
//
//  Created by Konstantin Schirmer on 23.02.22.
//

import Foundation


extension Endpoint where Kind == EndpointKinds.Public, Response == [Fixture] {
    
    static func getAllFixtures() -> Self {
        Endpoint(path: FmfUrlPaths.getAllFixtures.rawValue, httpMethod: .GET)
    }
    
}


extension Endpoint where Kind == EndpointKinds.Public, Response == [User] {
    
    static func getUser(by id: String) -> Self {
        var endPoint = Endpoint(path: FmfUrlPaths.getUserById.rawValue, httpMethod: .POST)
        endPoint.bodyData = ["id": id]
        return endPoint
    }
    
}

extension Endpoint where Kind == EndpointKinds.Public, Response == [LoginResponse] {
    
    static func getLoginEndpoint(username: String, password: String) -> Self {
        var endPoint = Endpoint(path: FmfUrlPaths.loginPath.rawValue, httpMethod: .POST)
        endPoint.bodyData = ["username": username, "password": password]
        return endPoint
    }
    
}
