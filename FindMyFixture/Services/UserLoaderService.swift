//
//  UserLoaderService.swift
//  FindMyFixture
//
//  Created by Student on 10.06.21.
//

import Foundation
import SwiftUI


class UserLoaderService {
    
    private let decoder = JSONDecoder()
    
    func getUserBy(userId: Int, completion: @escaping (Result<User, Error>) -> Void) {
        guard let url:URL = URL(string: "http://hasashi.bplaced.net/findmyfixture/php/getuser_byid_pdo.php") else {
            print("Invalid URL")
            completion(.failure(FmfLoadError.urlLoadError))
            return
        }
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        let bodyData:String = "id=\(userId)"
        request.httpBody = bodyData.data(using: String.Encoding.utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let httpResponse: HTTPURLResponse = response as? HTTPURLResponse else { return }
            let statusCode = httpResponse.statusCode
            print("statusCode: \(statusCode)")
            guard (200...299).contains(statusCode) else { return }
            guard let data = data else {
                print("could not get data")
                completion(.failure(FmfLoadError.dataLoadError))
                return }
            do {
                let dataResponse = try self.decoder.decode([User].self, from: data)
                DispatchQueue.main.async {
                    guard let user: User = dataResponse.first else { return }
                    print("\(user)")
                    completion(.success(user))
                }
            } catch let error as DecodingError {
                switch error {
                         case .typeMismatch(let key, let value):
                           print("error \(key), value \(value) and ERROR: \(error.localizedDescription)")
                         case .valueNotFound(let key, let value):
                           print("error \(key), value \(value) and ERROR: \(error.localizedDescription)")
                         case .keyNotFound(let key, let value):
                           print("error \(key), value \(value) and ERROR: \(error.localizedDescription)")
                         case .dataCorrupted(let key):
                           print("error \(key), and ERROR: \(error.localizedDescription)")
                         default:
                           print("ERROR: \(error.localizedDescription)")
                         }
                completion(.failure(error))
                } catch let error as NSError {
                    NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
                    completion(.failure(error))
                }
        }.resume()
    }
    
    
    
}
