//
//  ListSerachViewModel.swift
//  FindMyFixture
//
//  Created by Student on 11.06.21.
//

import Foundation
import SwiftUI
import Combine

class ListSearchViewModel: ObservableObject {
    
    @Published var fixturesToShow: [Fixture] = []
    private var fixtures = [Fixture]()
    
    private var cancellable: AnyCancellable?

    
    public func loadAllFixture(completion: @escaping (Bool) -> Void) {
        Repository.shared.loadAllFixtures { result in
            switch result {
            case .success(let fixtures):
                DispatchQueue.main.async {
                    self.fixtures = fixtures
                    self.fixturesToShow = fixtures
                    completion(true)
                }
            case .failure(_):
                completion(false)
            }
        }
    }
    
    public func searchFixturesByName(searchTerm: String) {
        filterFixtureListBy(searchTerm: searchTerm)
    }
    
    
    
    private func filterFixtureListBy(searchTerm: String) {
        if searchTerm.isEmpty {
            fixturesToShow = fixtures
        } else {
            fixturesToShow = fixtures.filter {
                $0.name.range(of: searchTerm, options: .caseInsensitive) != nil || $0.producer.range(of: searchTerm, options: .caseInsensitive) != nil
            }
        }
    }
}


