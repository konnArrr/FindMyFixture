//
//  EndPoint.swift
//  FindMyFixture
//
//  Created by Konstantin Schirmer on 07.02.22.
//

import Foundation
import Combine

protocol EndpointKind {
   static func prepare(_ request: inout URLRequest, with data: [RequestDataKeys:Any])
}

enum EndpointKinds {
    enum Public: EndpointKind {
        static func prepare(_ request: inout URLRequest, with data: [RequestDataKeys:Any]) {            
           
            // ugly hack
            if let bodyDic = data[.body] as? [AnyHashable : String], let id = bodyDic["id"] as String?,  let idData = "id=\(id)".data(using: .utf8) {
                request.httpBody = idData
            }
            
            if let httpMethod = data[RequestDataKeys.httpMethod] as? HttpMethod {
                request.httpMethod = httpMethod.rawValue
            }
            request.cachePolicy = .reloadIgnoringLocalCacheData
        }
    }
    
}




struct Endpoint<Kind: EndpointKind, Response: Decodable> {
    var path: String
    var queryItems = [URLQueryItem]()
}

extension Endpoint {
    
    var url: URL {
        var components = URLComponents()
        components.scheme = NetworkConstants.baseHttpScheme.rawValue
        components.host = NetworkConstants.baseHost.rawValue
        components.path = NetworkConstants.basePath.rawValue + path
        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }
        guard let url = components.url else {
            preconditionFailure(
                "Invalid URL components: \(components)"
            )
        }
        return url
    }
}

extension Endpoint {
    
    func makeRequest(with data: [RequestDataKeys:Any] = [:]) -> URLRequest? {
        var request = URLRequest(url: url)
        Kind.prepare(&request, with: data)
        return request
    }
    
}

extension Endpoint where Kind == EndpointKinds.Public, Response == [Fixture] {
    
    
    static func getAll() -> Self {
        Endpoint(path: "get_all_fixtures.php")
    }
    
}


extension Endpoint where Kind == EndpointKinds.Public, Response == [User] {
    
    static func getUserById() -> Self {
        Endpoint(path: FmfUrlPaths.getUserById.rawValue)
    }
    
    static func getAll() -> Self {
        Endpoint(path: FmfUrlPaths.getUserById.rawValue)
    }
    
}



