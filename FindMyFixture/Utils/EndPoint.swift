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
           
            // add specific requestData to request
            if let bodyDic = data[.body] as? [AnyHashable : Any] {
                let jsonData = try? JSONSerialization.data(withJSONObject: bodyDic, options: .prettyPrinted)
                request.httpBody = jsonData
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
    var httpMethod: HttpMethod
    var bodyData: [AnyHashable : Any]?
    
    
    var requestData: [RequestDataKeys:Any] {
        var requestData: [RequestDataKeys:Any] = [:]
        requestData[RequestDataKeys.httpMethod] = httpMethod
        if let bodyData = bodyData {
            requestData[RequestDataKeys.body] = bodyData
        }
        return requestData
    }
}

extension Endpoint {
    
    var url: URL {
        var components = URLComponents()
        components.scheme = URLConstants.baseHttpScheme.rawValue
        components.host = URLConstants.baseHost.rawValue
        components.path = URLConstants.basePath.rawValue + path
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



