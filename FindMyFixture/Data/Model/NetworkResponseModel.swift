//
//  NetworkResponseModel.swift
//  FindMyFixture
//
//  Created by Konstantin Schirmer on 08.02.22.
//

import Foundation

struct NetworkResponse<Wrapped: Decodable>: Decodable {
    var result: Wrapped
}

protocol Model: Identifiable, Codable {
    var id: Int { get }
}
