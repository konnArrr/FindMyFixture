//
//  RepositoryProtocol.swift
//  FindMyFixture
//
//  Created by Paul Sprotte on 07.02.22.
//

import Foundation

protocol RepositoryProtocol {
    
    associatedtype Model: Identifiable, Decodable
    
    func addModel(model: Model.ID, completion: @escaping (Result<Model, Error>) -> Void)

    func getModel(with id: Model.ID, completion: @escaping (Result<Model, Error>) -> Void)

    func updateModel(with model: Model, completion: @escaping (Result<Model, Error>) -> Void)
    
    func getAll(completion: @escaping (Result<[Model], Error>) -> Void)
    
}
