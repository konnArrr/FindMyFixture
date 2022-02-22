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
    
    enum Fixture {
        static let validFixture = FindMyFixture.Fixture(id: 1, name: "test", producer: "bla", power: 12, powerLight: 13, headMover: 0, goboWheels: 5, prisms: 4, minZoom: 12.3, maxZoom: 13.3, colorSystem: 3, dmxModes: 1, minDmx: 23, maxDmx: 24, weight: 12, comment: "", imageURL: "")
    }
}
