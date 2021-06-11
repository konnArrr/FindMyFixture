//
//  Repository.swift
//  FindMyFixture
//
//  Created by Student on 11.06.21.
//

import Foundation
import SwiftUI


class Repository {
    
    static let shared = Repository()
    private init() {}
    
    
    private var fixtures = [Fixture]()
    
    @Published var fixturesToShow = [Fixture]()
    
    private let fixtureLoader = FixtureLoader()
    
    
    public func loadAllFixtures() {
        fixtureLoader.loadAllFixtures { (loadedFixtures) in
            self.fixtures = loadedFixtures
            self.fixturesToShow = loadedFixtures
        }
    }
    
    func filterFixtureListBy(searchTerm: String) {
        if searchTerm.isEmpty {
            fixturesToShow = fixtures
        } else {
            fixturesToShow = fixtures.filter {
                $0.name.range(of: searchTerm, options: .caseInsensitive) != nil || $0.producer.range(of: searchTerm, options: .caseInsensitive) != nil
            }
        }
    }
    
    
    
    
    
}
