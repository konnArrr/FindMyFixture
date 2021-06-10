//
//  LoginDataModel.swift
//  FindMyFixture
//
//  Created by Student on 10.06.21.
//

import Foundation


struct LoginResponse: Codable {
    let state: String
    let message: String
    let userId: String
}
