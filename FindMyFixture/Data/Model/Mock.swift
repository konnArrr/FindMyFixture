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
        static let validFixture = FindMyFixture.Fixture(id: 1, name: "Quantum", producer: "Martin", power: 1200, powerLight: 700, goboWheels: 2, prisms: 3, minZoom: 15.0, maxZoom: 45.0, dmxModes: 2, minDmx: 27, maxDmx: 45, weight: 26, comment: "Klassiker und macht was er soll", imageURL: "http://hasashi.bplaced.net/findmyfixture/images/default_mh.png", colorSysEnum: .cmy, lampType: .headmover)
        
        static let addingFixture = FindMyFixture.Fixture(id: 1, name: "SlimPAR Pro Q", producer: "Chauvet", power: 120, powerLight: 700, goboWheels: 2, prisms: 3, minZoom: 16, maxZoom: 31, dmxModes: 3, minDmx: 4, maxDmx: 10, weight: 3, comment: "klein aber fein", imageURL: "http://hasashi.bplaced.net/findmyfixture/images/default_mh.png", colorSysEnum: .rgbw, lampType: .nonHeadMover)
    }
    
    enum StatusCodes {
        static let code404 = 404
    }
}
