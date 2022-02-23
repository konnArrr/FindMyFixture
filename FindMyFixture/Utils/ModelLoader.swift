//
//  ModelLoader.swift
//  FindMyFixture
//
//  Created by Konstantin Schirmer on 07.02.22.
//

import Foundation
import Combine

class ModelLoader{
    
    static let shared = ModelLoader()
    private init() {}
    
    var urlSession = URLSession.shared

    private var cancellable: AnyCancellable?

    
    public func loadModel<K: EndpointKind, T>(endPoint: Endpoint<K, T>, completion: @escaping (Result<T, Error>) -> Void ) {        

        let session = urlSession.publisher(endpoint: endPoint)
        self.cancellable = session
            .sink(receiveCompletion: { (result) in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    completion(.failure(error))
                }
            }, receiveValue: { (data) in
                    completion(.success(data))
            })
    }
    
    public func loadUser(by id: String, completion: @escaping (Result<[User], Error>) -> Void) {
        let endPoint = Endpoint<EndpointKinds.Public, [User]>.getUser(by: id)
        loadModel(endPoint: endPoint, completion: completion)
    }
    
    public func getAllFixtures(completion: @escaping (Result<[Fixture], Error>) -> Void) {
        loadModel(endPoint: Endpoint<EndpointKinds.Public, [Fixture]>.getAllFixtures(), completion: completion)
    }
    
    
    
    
}


