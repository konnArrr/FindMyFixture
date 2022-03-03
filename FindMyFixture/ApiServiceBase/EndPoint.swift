//
//  EndPoint.swift
//  FindMyFixture
//
//  Created by Konstantin Schirmer on 07.02.22.
//

import Foundation
import Combine

protocol EndpointKind {
   static func prepare(_ request: inout URLRequest, with requestData: RequestDataModel)
}

enum EndpointKinds {
    enum Public: EndpointKind {
        static func prepare(_ request: inout URLRequest, with requestData: RequestDataModel) {
            // add specific requestData to request
            if let bodydata = requestData.bodyData {
                let encoder = JSONEncoder()
                let jsonData = try? encoder.encode(bodydata)
                if let jsonData = jsonData {
                    let jsonString = String(data: jsonData, encoding: .utf8)!
                    print("jsonString: \(jsonString)")
                }
                
                request.httpBody = jsonData
            }
            request.httpMethod = requestData.httpMethod.rawValue
            
            request.cachePolicy = .reloadIgnoringLocalCacheData
        }
    }
    
}




struct Endpoint<Kind: EndpointKind, Response: Decodable> {
    var path: String
    var requestData: RequestDataModel
    
    
//    var requestData: [RequestDataKeys:Any] {
//        var requestData: [RequestDataKeys:Any] = [:]
//        requestData[RequestDataKeys.httpMethod] = httpMethod
//        if let bodyData = bodyData {
//            requestData[RequestDataKeys.body] = bodyData
//        }
//        return requestData
//    }
}

extension Endpoint {
    
    var url: URL {
        var components = URLComponents()
        components.scheme = URLConstants.baseHttpScheme.rawValue
        components.host = URLConstants.baseHost.rawValue
        components.path = URLConstants.basePath.rawValue + path
        if let queryItems = requestData.queryItems {
            components.setQueryItems(with: queryItems)
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
    
    func makeRequest() -> URLRequest? {
        var request = URLRequest(url: url)
        Kind.prepare(&request, with: self.requestData)
        return request
    }
    
}


extension URLComponents {
    
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}



