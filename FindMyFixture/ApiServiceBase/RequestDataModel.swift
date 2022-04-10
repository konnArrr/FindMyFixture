//
//  BodyDataModel.swift
//  FindMyFixture
//
//  Created by Konstantin Schirmer on 02.03.22.
//

import Foundation

struct RequestDataModel <T: BodyDataModel> {
    var httpMethod: HttpMethod
    var queryItems: [String : String]?
    var bodyData: T?
}

enum HttpMethod : String, Codable {
    case  GET
    case  POST
    case  DELETE
    case  PUT
}
