//
//  Mock.swift
//  FindMyFixtureTests
//
//  Created by Konstantin Schirmer on 09.02.22.
//

import Foundation

enum Mock {
    
    enum User {
        static let validUser = FindMyFixture.User(id: 1, username: "admin", password: "admin", adminRights: 1, registerDate: "2021-06-07 00:00:00")
    }
}
