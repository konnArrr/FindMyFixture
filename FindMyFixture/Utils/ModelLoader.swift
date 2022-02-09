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
    
    //    var urlResolver: (Model.ID) -> URL
//
//    func loadModel(withID id: Model.ID) -> AnyPublisher<Model, Error> {
//        urlSession.publisher(url: urlResolver(id))
//    }
    
    private func loadPublisherUser(id: String) -> AnyPublisher<[User], Error> {
        urlSession.publisher(endpoint: .getUserById(id: id), using: [RequestDataKeys.httpMethod: HttpMethod.POST, RequestDataKeys.body: ["id":id]])
    }
    
    func loadUserBy(id: String, completion: @escaping (Result<User, FmfLoadError>) -> Void) {
        self.cancellable = loadPublisherUser(id: id)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    fatalError(error.localizedDescription)
                }
            }, receiveValue: { (users) in
                if let user = users.first {
                    completion(.success(user))
                } else {
                    completion(.failure(.dataLoadError))
                }                
            })
    }
    
}


