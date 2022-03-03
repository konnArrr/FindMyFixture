//
//  NetworkResponseModel.swift
//  FindMyFixture
//
//  Created by Konstantin Schirmer on 02.03.22.
//

import Foundation

struct NetworkResponse<Wrapped: Decodable>: Decodable {
    var result: Wrapped
}
