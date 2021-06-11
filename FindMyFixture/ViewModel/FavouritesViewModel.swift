//
//  FavouritesViewModel.swift
//  FindMyFixture
//
//  Created by Student on 11.06.21.
//

import Foundation
import Combine

class FavouritesViewModel: ObservableObject {
    @Published private(set) var favouriteFixturesVm = [Fixture]()
    private var cancellbale: AnyCancellable?
    init() {
        cancellbale = StorageLoader.shared.$favouriteFixtures.sink(receiveValue: { [weak self] favouriteFixtures in
            self?.favouriteFixturesVm = favouriteFixtures
        })
    }
    
    func deleteFromFavouriteList(at offsets: IndexSet) {
        StorageLoader.shared.deleteFromFavouriteFixtureListBy(at: offsets)
    }
    
    func moveFavouriteList(from source: IndexSet, to destination: Int) {
        StorageLoader.shared.moveFavouriteFixturesListBy(from: source, to: destination)
    }
    
}
