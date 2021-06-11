//
//  UserModel.swift
//  FindMyFixture
//
//  Created by Student on 10.06.21.
//

import Foundation

struct User: Codable {
    let id: Int
    let username, password: String
    let adminRights: Int
    let registerDate: String
}
