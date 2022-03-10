//
//  AddViewModel.swift
//  FindMyFixture
//
//  Created by Student on 11.06.21.
//

import Foundation
import SwiftUI

class AddViewModel: ObservableObject {
    
    @Published var message: String = ""
    
    @Published var fixture = Fixture(id: 1, name: "", producer: "", power: 0, powerLight: 0, headMover: 0, goboWheels: 0, prisms: 0, minZoom: 0.0, maxZoom: 0.0, colorSystem: 1, dmxModes: 0, minDmx: 0, maxDmx: 0, weight: 0, comment: "", imageURL: "http://hasashi.bplaced.net/findmyfixture/images/default_bulb.png")
    
    public func addFixture(completion: @escaping (Bool) -> Void) {
        Repository.shared.addFixture(with: fixture) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.message = response.message
                    completion(true)
                case .failure(let error):
                    self.message = error.localizedDescription
                    completion(false)
                }
            }            
        }
    }
    
    
    
}
