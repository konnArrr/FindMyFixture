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
    
    
    
    public func addFixture(with fixture: Fixture, completion: @escaping (Bool) -> Void) {
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
