//
//  ListRowViewModel.swift
//  FindMyFixture
//
//  Created by Student on 10.06.21.
//

import Foundation
import SwiftUI

class RowViewModel: ObservableObject {
    
    @Published var fixtureImage: UIImage?
    
    private let imageLoader = ImageLoaderService.shared
    
    public func getFixtureImage(imageURLString: String) {
        imageLoader.loadImage(for: imageURLString) { [weak self] result in
            switch result {
            case .success(let loadImage):
                self?.fixtureImage = loadImage
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
}
