//
//  StorageLoader.swift
//  FindMyFixture
//
//  Created by Student on 11.06.21.
//

import Foundation
import SwiftUI
import Combine

class StorageLoader {
    
    static let shared = StorageLoader()
    @Published var favouriteFixtures = [Fixture]()
    @AppStorage("favouriteFixtures") private var dataForAppStorage: Data = Data()
    
    private var cancellables: Set<AnyCancellable> = []
    
    private init() {
        loadFavouriteFixturesList()
        
        NotificationCenter.Publisher(center: .default, name: .addFavouriteFixtureMessage)
            .sink { notification in
                let object = notification.object
                guard let fixture = object as? Fixture else { return }
                self.saveToFavouriteFixtureList(fixture: fixture )
            }.store(in: &cancellables)
    }
    
    public func moveFavouriteFixturesListBy(from source: IndexSet, to destination: Int) {
        favouriteFixtures.move(fromOffsets: source, toOffset: destination)
        saveFavouriteFixtureList()
    }
    
    public func deleteFromFavouriteFixtureListBy(at offsets: IndexSet) {
        favouriteFixtures.remove(atOffsets: offsets)
        saveFavouriteFixtureList()
    }
    
    public func saveToFavouriteFixtureList(fixture: Fixture) {
        favouriteFixtures.append(fixture)
        saveFavouriteFixtureList()
        print("saved")
    }
    
    private func saveFavouriteFixtureList() {
        guard let dataToSaveData: Data = try? JSONEncoder().encode(favouriteFixtures) else { return }
        self.dataForAppStorage = dataToSaveData
    }
    
    public func loadFavouriteFixturesList() {
        guard let loadedDataObject = try? JSONDecoder().decode([Fixture].self, from: dataForAppStorage) else { return }
        favouriteFixtures = loadedDataObject
    }
     
    
}

extension Notification.Name {
    static let addFavouriteFixtureMessage = Notification.Name("addFavouriteFixtureMessage")
}
