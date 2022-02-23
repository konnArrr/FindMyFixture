//
//  ModelLoader.swift
//  FindMyFixture
//
//  Created by Konstantin Schirmer on 07.02.22.
//

import Foundation
import Combine

class ApiService{
    
    static let shared = ApiService()
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
      
    
}


