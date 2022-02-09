//
//  URLSession+Extensions.swift
//  FindMyFixture
//
//  Created by Konstantin Schirmer on 07.02.22.
//

import Foundation
import Combine


extension URLSession {
    
    func publisher<T: Decodable>(
        url: URL,
        responseType: T.Type = T.self,
        decoder: JSONDecoder = .init()
    ) -> AnyPublisher<T, Error> {
        dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: NetworkResponse<T>.self, decoder: decoder)
            .map(\.result)
            .eraseToAnyPublisher()
    }
    
//    func publisher<K, R>(
//        endpoint: Endpoint<K, R>,
//        using requestData: [RequestDataKeys:Any] = [:],
//        decoder: JSONDecoder = .init()
//    ) -> AnyPublisher<R, Error> {
//        guard let request = endpoint.makeRequest(with: requestData) else {
//            return Fail(
//                error: FmfLoadError.dataLoadError
//            ).eraseToAnyPublisher()
//        }
//
//        return dataTaskPublisher(for: request)
//            .tryMap() {
//                    guard $0.data.count > 0 else { throw URLError(.zeroByteResource) }
//                    return $0.data
//                }
//            .decode(type: NetworkResponse<R>.self, decoder: decoder)
//            .map(\.result)
//            .eraseToAnyPublisher()
//    }
    
    func publisher<K, R>(endpoint: Endpoint<K, R>, using requestData: [RequestDataKeys:Any] = [:],decoder: JSONDecoder = .init()) -> AnyPublisher<R, Error>    {
        guard let request = endpoint.makeRequest(with: requestData) else {
            return Fail(
                error: FmfLoadError.dataLoadError
            ).eraseToAnyPublisher()
        }        
        return dataTaskPublisher(for: request)
                .tryMap { output in
                    guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                        throw HTTPError.statusCode
                    }
                    return output.data
                }
            .decode(type: R.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
    
    
}
