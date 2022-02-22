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

    
    public func loadModel<K: EndpointKind, T>(by id: String, endPoint: Endpoint<K, T>, completion: @escaping (Result<T, FmfLoadError>) -> Void ) {
        
        let requestData = [RequestDataKeys.httpMethod: HttpMethod.POST, RequestDataKeys.body: ["id":id]] as [RequestDataKeys : Any]
        let session = urlSession.publisher(endpoint: endPoint, using: requestData)
        self.cancellable = session
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    fatalError(error.localizedDescription)
                }
            }, receiveValue: { (data) in
                    completion(.success(data))
            })
    }
    
    
    
    
}


