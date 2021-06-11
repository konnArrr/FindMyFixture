//
//  AddViewModel.swift
//  FindMyFixture
//
//  Created by Student on 11.06.21.
//

import Foundation
import SwiftUI

class AddViewModel: ObservableObject {
    
    private let addService = FixtureAdding()
    
    @Published var fixtureToAdd = Fixture(id: 1, name: "name", producer: "producer", power: 0, powerLight: 0, headMover: 0, goboWheels: 0, prisms: 0, minZoom: 0.0, maxZoom: 0.0, colorSystem: 1, dmxModes: 0, minDmx: 0, maxDmx: 0, weight: 0, comment: "comment", imageURL: "http://hasashi.bplaced.net/findmyfixture/images/default_bulb.png")
    
    @Published var message: String = ""
    
    public func addFixture() {
        addService.addFixture(fixture: fixtureToAdd) { (msg) in
            self.message = msg
        }
    }
    
    
    
}
