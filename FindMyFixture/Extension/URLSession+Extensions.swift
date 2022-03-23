//
//  URLSession+Extensions.swift
//  FindMyFixture
//
//  Created by Konstantin Schirmer on 07.02.22.
//

import Foundation
import Combine

extension URLSession {

    func publisher<K, R>(endpoint: Endpoint<K, R>,decoder: JSONDecoder = .init()) -> AnyPublisher<R, Error> {
        guard let request = endpoint.makeRequest() else {
            return Fail(
                error: FmfLoadError.dataLoadError
            ).eraseToAnyPublisher()
        }
        return dataTaskPublisher(for: request)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse else {
                    throw FmfLoadError.dataLoadError
                }
                guard response.statusCode == 200 else {
                    throw FmfLoadError.statusCode(response.statusCode)
                }
                return output.data
            }
            .decode(type: NetworkResponse<R>.self, decoder: JSONDecoder())
            .map(\.result)
            .eraseToAnyPublisher()
    }
    
}
