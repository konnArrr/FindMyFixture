//
//  NetworkConstants.swift
//  FindMyFixture
//
//  Created by Konstantin Schirmer on 08.02.22.
//

import Foundation

enum URLConstants: String {
    case baseHttpScheme = "http"
    case baseHost = "hasashi.bplaced.net"
    case basePath = "/findmyfixture/php/"
}


enum RequestDataKeys: String {
    case httpMethod
    case body
}


enum HttpMethod : String {
   case  GET
   case  POST
   case  DELETE
   case  PUT
}
