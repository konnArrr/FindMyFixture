//
//  FixtureLoaderService.swift
//  FindMyFixture
//
//  Created by Student on 10.06.21.
//

import Foundation
import SwiftUI
import Combine

enum HTTPError: LocalizedError {
    case statusCode
}



class FixtureLoader: ObservableObject {
    

    private var cancellable: AnyCancellable?
    
    
    func loadAllFixtures(completion: @escaping ([Fixture]) -> Void) {
        guard let url:URL = URL(string: "http://hasashi.bplaced.net/findmyfixture/php/get_all_fixtures.php") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url:url)
        self.cancellable = URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw HTTPError.statusCode
                }
                return output.data
            }
            .decode(type: [Fixture].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .eraseToAnyPublisher()
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    fatalError(error.localizedDescription)
                }
            }, receiveValue: { (fixtures) in
                completion(fixtures)
            })
        // self.cancellable?.cancel()
    }
    
    
}
