//
//  Repository.swift
//  FindMyFixture
//
//  Created by Student on 11.06.21.
//

import Foundation
import SwiftUI

private let logger = Logger.getLogger(Repository.self, level: .verbose)


class Repository {
    
    static let shared = Repository()
    private init() {}
    

    public func loadAllFixtures(completion: @escaping (Result<[Fixture], Error>) -> Void) {
        ApiService.shared.getAllFixtures { result in
            switch result {
            case .success(let fixtures):
                logger.info("get all fixtures successful with: \(fixtures)")
                completion(.success(fixtures))
            case .failure(let error):
                logger.error(error)
                completion(.failure(error))
            }
        }
    }
    
    public func addFixture(with fixture: Fixture, completion: @escaping (Result<PhpResponse, Error>) -> Void) {
        ApiService.shared.addFixture(by: fixture) { result in
            switch result {
            case .success(let response):
                logger.info("fixture added with response: \(response)")
                completion(.success(response))
            case .failure(let error):
                logger.error(error)
                completion(.failure(error))
            }
        }
    }
    
    public func getUser(by data: UserBodyDataModel, completion: @escaping (Result<User, Error>) -> Void) {
        ApiService.shared.loadUser(by: data) { result in
            switch result {
            case .success(let user):
                logger.info("get all fixtures successful with: \(user)")
                completion(.success(user))
            case .failure(let error):
                logger.error(error)
                completion(.failure(error))
            }
        }
    }
    
    
    
    
    
    
    
}
