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
    
    @Published private(set) var fixturesToShow = [Fixture]()
    
    private var cancellable: AnyCancellable?
    
    init() {
        cancellable = Repository.shared.$fixturesToShow.sink(receiveValue: { [weak self] loadedFixtures in
            // nötig weil folgender error: Publishing changes from background threads is not allowed; make sure to publish values from the main thread (via operators like receive(on:)) on model updates. das scheint zu helfen
            DispatchQueue.main.async {
                self?.fixturesToShow = loadedFixtures
            }
        })
    }
    
    public func loadAllFixture() {
        Repository.shared.loadAllFixtures()
    }
    
    public func searchFixturesByName(searchTerm: String) {
        Repository.shared.filterFixtureListBy(searchTerm: searchTerm)
    }
    
    
    
    
}
