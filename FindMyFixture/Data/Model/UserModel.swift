//
//  UserModel.swift
//  FindMyFixture
//
//  Created by Student on 10.06.21.
//

import Foundation




public struct User: BodyDataModel, Equatable {
    public let id: Int
    let username, password: String
    let adminRights: Int
    let registerDate: String

}

typealias UserData = [User]
